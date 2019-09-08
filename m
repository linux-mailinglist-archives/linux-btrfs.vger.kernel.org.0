Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E470AD048
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Sep 2019 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730554AbfIHR6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 Sep 2019 13:58:20 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53600 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730531AbfIHR6U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 Sep 2019 13:58:20 -0400
Received: by mail-wm1-f43.google.com with SMTP id q19so11303335wmc.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Sep 2019 10:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XaZNTlC9KgmJHY7VWLtbf27AzyORqd1g5Gm00PIMu4M=;
        b=MU2yNoQZvT9wO/T3cVwbBfNF6jfpd8mBl2m63P3IexRXeyReitYVb5bsVOvoaPgANa
         AuRMPOuRny0AxMftQxZe3Svp1kbJu/H0rsNy9lm7VaCADVZUZlJ/J265/RwaW/i5tjCU
         EkWO2MkZDDhrPO4FLdoRcUGBEcMXT6zMo+ALx2g8gWFhUTAt+7kDvyPFHg4WAflw088W
         Ajr9wgDLnbzuzeRnr8LfK1NgnQvvFEO3YdnMJWdtEZhmp8XWaMXmXFq1NjK1Wi2IDkBq
         saoLPIsv99zYp1yWowln9nsDmdXarHhgZmChy1s0ONOevgAcOf0yjr3MRVNcvcTKNxD2
         o23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XaZNTlC9KgmJHY7VWLtbf27AzyORqd1g5Gm00PIMu4M=;
        b=VXXcqXb87bnagoDq96TNyQk/H7njLOY3tusQNVdCnu+yIiviABBlueqkBXKeg1NTKW
         JA02pZyb04BjnQHvkW6+Ohv6jsmjpRwxD8RGsc8mYMTm6dzU58ejYd0nXy3fJLA2tZ/H
         CP7uvZwaYVVyHqSSgn+aotAlYtUyqGoD7tjCUrTTgaSmjr+d+WKKJWUgVYVwFYedLRPa
         H0Yq5XjjBjBcwW8kjymV78OT8NPGTqKA7hsrAftXRhPhemdlXwGRa2p2c2LZMEIRE+eX
         mHfOUnJv94hzeUsuefEnbXA2u3kxjiy7e89nruN+E5pjFULDnogPqEL8z9YZND9pN2Pc
         4Jqg==
X-Gm-Message-State: APjAAAUtI1944b8HHKDuYDk/F8bXbvcjDfIQSJOidznDPagRZU5JhusZ
        M4tFJayv+4JdBhq5ytJVpkc7E6BzB+eBhgt4usk7doAedJFduQ==
X-Google-Smtp-Source: APXvYqz33LVPApeoUtsjdblDAx0nEH1IW5x6B9icrDKwfgIQgPLj9jsSpDZ/oaxarZ3ZLZLxdLBDm5qwv+u7imSycmc=
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr15845545wmg.8.1567965498003;
 Sun, 08 Sep 2019 10:58:18 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 8 Sep 2019 11:58:07 -0600
Message-ID: <CAJCQCtQueeFf=4m0Y2t3Qxzh_qT=PKwY5CPe4MmBb1wx3xyDfg@mail.gmail.com>
Subject: user_subvol_rm_allowed vs rmdir_subvol
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Came across this podman issue yesterday
https://github.com/containers/libpod/issues/3963


Question 1: For unprivileged use case, is it intentional that the user
creates a subvolume/snapshot using 'btrfs sub create' and that the
user delete it with 'rm -rf' ?

And is the consequence of this performance? Because I see rm -rf must
individually remove all files and dirs from the subvolume first,
before rmdir() is called to remove the subvolume. Where as 'btrfs sub
del' calls BTRFS_IOC_SNAP_DESTROY ioctl which is pretty much
immediate, with cleanup happening in the background.


Question 2:

As it relates to the podman issue, what do Btrfs developers recommend?
If kernel > 4.18, and if unprivileged, then use 'rm -rf' to delete
subvolumes? Otherwise use 'btrfs sub del' with root privilege?


Question 3:
man 5 btrfs has a confusing note for user_subvol_rm_allowed mount option:

               Note
               historically, any user could create a snapshot even if
he was not owner of the source subvolume, the subvolume deletion has
been restricted
               for that reason. The subvolume creation has been
restricted but this mount option is still required. This is a
usability issue.

2nd sentence "subvolume creation has been restricted"  I can't parse
that. Is it an error, or can it be worded differently?


-- 
Chris Murphy
