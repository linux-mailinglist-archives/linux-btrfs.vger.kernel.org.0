Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C714E43D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgA3Urk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 15:47:40 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:35450 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3Urk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 15:47:40 -0500
Received: by mail-qv1-f43.google.com with SMTP id u10so2206054qvi.2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2020 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASu10jPLjaYCzrTwlkxm9blhjqm29mbvPHzhzhLwJnk=;
        b=pfnTKQqUzwzwed31aKfVYFYl5nsOBIu1WtzusUcIt33TfC7+tdPTGcq2JqCg2L26w9
         EjaPrCzbpUKlrnUUx3BX6dG6QoNbdZehd159DEL+rpg9K9WjScjKhAQ8aTtllrUUO08c
         qX57HQTlWDh85FcjwB4MeZUWg94EZ+1MRXZxruI0NC+Lz0X8b+dohMRJzlmIq1kJKJDd
         I18Nk8fozYS4uPyv+1xYajMV3M04D3pDPN8bWubdJyHG1TTKMEBUfjFGK7mojhAXWlI+
         /0Qt65xS3L4Bo/5XeCS34upZo96IE0f3cLUHL3Nc2ZDzDl0f58nM2K81RqhZM43NW+oY
         SmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ASu10jPLjaYCzrTwlkxm9blhjqm29mbvPHzhzhLwJnk=;
        b=iZlw9jIdJbzCQsCl1jFmL+savv9nRSjrQMy0md3D6YZX+T2pMi/5ZKJ9SKeyQ3wsdH
         zh1BcWjHoQc74LsqgxcMMiaQfLErqs+ZvpUOWVZULJhe2pJjLMn+OgNWGpAOlwYyUT4T
         P/zIwDm8bj+rPSfjYrC44o1LPuujF50rW6kIrRRKQXQhyyNpuYSJOJPsm1O/Gp4lNCgp
         QsyL8yszwd2qotojF8RP4dJBRePXV+sHB9+N1w+XF4YdkTbVC1sxtgvhaZ2QpQydljh+
         L4F37jGQu1i2JQZmHpvMX9xhT6X13IQJhoVDk9BORLtDeSM7MoeYSNXrqix7HcHcwEYB
         cpRw==
X-Gm-Message-State: APjAAAU98yMk7G0wx/7AmfmAbEAq01FChq/0nxMBP2cEOtQp3xTBG9iv
        4JyuR/zfM0QH52OEUuvIeCgJx/GLCa2YzA==
X-Google-Smtp-Source: APXvYqyvWLEz6iEN3pXZK8/MvxdUDOrC159wx06EU7i4mizXtaeU0DGtmLj5baYJwHKODTk5HHvJ5Q==
X-Received: by 2002:a05:6214:209:: with SMTP id i9mr6797560qvt.54.1580417259000;
        Thu, 30 Jan 2020 12:47:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k62sm3375628qkc.95.2020.01.30.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:47:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/2] Fix btrfs check handling of missing file extents
Date:   Thu, 30 Jan 2020 15:47:34 -0500
Message-Id: <20200130204736.49224-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While adding an xfstest for the missing file extent problem I fixed with the
series

  btrfs: fix hole corruption issue with !NO_HOLES

I was failing to fail my test without my patches, despite the file system being
actually wrong.

It turns out because the normal check mode sets its expected start to the first
file extent it finds, instead of 0.  This means it misses any gaps between 0 and
the first file extent item in the inode.

The lowmem check does not have this issue, instead it doesn't take into account
the isize of the inode, so improperly fails when we have a gap but that is
outside of the isize.  I fixed this as well.

With these patches we're able to properly find another set of corruptions, and
now my xfstest acts sanely.  Thanks,

Josef

