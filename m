Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8811225617D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgH1Tog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Aug 2020 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgH1Tof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Aug 2020 15:44:35 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97DC061264
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 12:44:34 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id s1so196137iot.10
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Aug 2020 12:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=T8/fYHua5F2PeciZImX/RpLU2r1zwgXbDGtNX1Q5yKI=;
        b=Taxo0S1nu1jjIQWbfKW+S9vTcLQpAJPU9gD4zeGs91I97EHS2hrmXoWJTfMDPwG6C3
         Zts+Ci7jsn7vQfMIAtzpIQ9ZiLYjRt8SU3ai8VMUa3CGXkkOlWoUVwEFr1RT+fynHcLN
         znIyTiLr+z/R6H0DX9fwQ6U6lbfAR8UbVqLCidVfCt9GIlxhFWZE8F8PiyclDlLVMEbh
         Gcpe9EQQ/lT0guldJ8qsOlYN+g+GbUTDdC9Cjtv9AftweNbQiVkNEXzpy6Rn830F3P5K
         wHY1e1nreHDx2BNGJDHCzTcUo0tTcPBeaVFzEA/IkHWPWBCjznIv443a81pI2NKlKQjT
         EHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=T8/fYHua5F2PeciZImX/RpLU2r1zwgXbDGtNX1Q5yKI=;
        b=pBfLYCwlVzQ1aE4YJCJMLwVuTsmzBAtJCDFy5MQIULk8xGPxFVgjtwlYED/T8kJ1Nt
         hL0Z2VLiB5OsaxZzvslbM7jG3ryhqVoZafBGQZe2zdLs02lHNg9+L1o+hXIPaZV+mmxM
         evBF/uEzixu8l6nZzfW5gNHsxr3jIglSHsJDQSL9xmXwEmaG6brjn4mrWmsb1L7cKpXy
         l8qhzXnDSa8VglLDIfVrx0Mrp4QAA5SlnALjHpDLjG+mVjaDDWeqnb2tV+TrI94suTMa
         4HRcp/Ij13dqqYA/yLzV9fCwmwIzwrj1mLFw38HrFLJWz6URi1aegyplHl9bPtdtaEUe
         RRSw==
X-Gm-Message-State: AOAM531l9wFSVpQC7+1uIgtLWoaLmnaRzIPJjw+GIQetCo7i7ntRlvTo
        W64t+BR/NggeTrjTfooS3iRYumlLqp6pCHSbdIZqfWQwvddqrw==
X-Google-Smtp-Source: ABdhPJyzDN7jBSBGU8UIl6vQMbTqhvId5YKWMTEblYJfFoqxw7Pq7c2YA2yQMHi6cG1j6TN3/CaNgtCW2Esr8eRaJ9A=
X-Received: by 2002:a5d:80cb:: with SMTP id h11mr244111ior.189.1598643871467;
 Fri, 28 Aug 2020 12:44:31 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 28 Aug 2020 15:43:55 -0400
Message-ID: <CAEg-Je_Mhx2QewCvFbwcV5oVHHa9jkdPcpkFZN8YR_fktCHSCQ@mail.gmail.com>
Subject: Optional case-insensitivity
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Mark Harmstone <mark@harmstone.com>,
        Chris Murphy <lists@colorremedies.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey,

So I saw today on LWN an article about ext4 gaining the ability to do
per file/folder case-insensitivity[1]. I can see some value in this
property existing for subvolume/folder/file level for Btrfs for things
like Wine and Darling, which could take advantage of this to help
support Windows and macOS applications that expect insensitivity to
work properly. In particular, I'm looking at how games are glitchy
with case sensitivity because it's rarely tested (both Windows and
macOS are case-insensitive by default).

Has anyone looked at what it would take to do this in Btrfs too?

[1]: https://lwn.net/Articles/829737/

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
