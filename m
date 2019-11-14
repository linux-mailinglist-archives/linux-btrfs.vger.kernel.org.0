Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256E1FCA63
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNP6m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 10:58:42 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:37634 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfKNP6l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 10:58:41 -0500
Received: by mail-qk1-f180.google.com with SMTP id e187so5410878qkf.4
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2019 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szHo+P2PSiz+xMNI9xO5k2lAHGTQwAPwywh7skxacKs=;
        b=pqLM/VG4r0hbIb49jc0yxf+9VLq2ZGr0dC1byrmvmNIlB1JfJL4+luHiH0qI6lQTlY
         Aa0+4TWbUO10LOltRbPvZI/aqdfHfxbgrHrrEIAta+CV/PVJpllmkwQoXpX+6F+dCM4E
         rs4H6NqziKxPL75PCQHx2DsI1e9r3OvlazPv7HtsELoNMdKCVdUrIIFSYzBa3GA038yC
         9YYgy8kJUkcyEd1RsegRGb2WuNS4B5Dg+Nv2uTu+5HXi8eZnUnOjN+c1Nq7s3gBSStGw
         2/56sgMnEpAwJulumEsmr4OwUsZa+UiUJdVQHzQGCofChOt9X5HQtU4JVIY+GMsGOQcg
         e2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=szHo+P2PSiz+xMNI9xO5k2lAHGTQwAPwywh7skxacKs=;
        b=ql/3iqkndR72Xo3/BfEnfnoaERRfO/udlL6xWJoATXD8UnByyy/5n+1tfJ7oP2TJBZ
         UEsfoH1hv6fPJlwURYQ15M8eNcdT8JnvZ1G4wUG6KJbhiFW1aIJ3rMRaidXzLbsMSrgD
         4LXoeVohFlXWxxmtb3xuUD5Z6aZ2jThK8NkOIK3MWZ/A3GSpmHL8my/GJmZpqUhOlZnf
         mMwao4BCGX6vuZB1tR3DPnutx0jnvv4ZaPEfwiMD1yGeywutcB5oJGb8uXEahid9fp47
         aP/+NG8Ul6emcxFDazT+cjed4PU31rnIu1/vD/2C40AykbYyQEzIh1NVTCvN5mgIntvh
         jcFw==
X-Gm-Message-State: APjAAAVbl9oiiWyl4Q9KIYSMdTSMtgbPI7vR8BeSSn7NQ3n6JTzpDfFH
        7E4bNE8RvVOfJBpeAmJ1MWs1JA==
X-Google-Smtp-Source: APXvYqyKnFRan4srSlpE1AZ7le1Vd9FwkPf6fXLl0tHlNV5ilewXQ6gtDC0tCzMmf090rro4v06Apw==
X-Received: by 2002:a37:9e05:: with SMTP id h5mr7656911qke.76.1573747119185;
        Thu, 14 Nov 2019 07:58:39 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 7sm2888051qkf.67.2019.11.14.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 07:58:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fsstress: add support for btrfs subvol and snapshot ops
Date:   Thu, 14 Nov 2019 10:58:33 -0500
Message-Id: <20191114155836.3528-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs it would be nice to exercise our subvol and snapshot operations with
fsstress as well.  The set of patches adds this ability.  I've added a new file
type for subvolumes, and they behave just like directories for all intents and
purposes.  The bulk of the supporting code needed for this went into the first
patch, as well as the code to add the ability to link in libbtrfsutil.  The
second patch is more straightforward as it just adds the snapshot operation, and
the final patch goes through and makes everybody pick either a directory or
subvolume for their target file.  I've done a bunch of testing with this on
btrfs to make sure everything works as expected.  I then did a follow up run on
xfs to verify I didn't break the non-btrfs case.  Thanks,

Josef

