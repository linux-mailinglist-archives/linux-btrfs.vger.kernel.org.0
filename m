Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1319DAD7
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 02:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfH0A4A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 20:56:00 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44975 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfH0A4A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 20:56:00 -0400
Received: by mail-wr1-f48.google.com with SMTP id p17so16994984wrf.11
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 17:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=taeI4zZYBRlKvHCehSw5hhGxCvqYCUSI5+8Jldlhf6A=;
        b=A3ZDofiIh/K30PfaFCg65IU6cCFq4uHWo6lQ4WKq+hYPYl+WWnyM9JnzQ+R14MPGVW
         YD8J+xKC5W6VzBTQgpPlwYkFu+R0v3jQ8gjGZRNxRGCo3/c7kyTXWC7TQJwPvVRCJ/HQ
         kCUekjQXX+0wlVYIXotmkdS8RiRO0ktSCXUFrYC7CKpk2wWiHydJSZqNfaZ17gxp59E1
         2SKtI4S7V1eDtPQ2fOZRQ2aTleFXKl8JWVSsmDEJAAdpIW5loH+xctxNGcsvCMKLHt8t
         1tasq4jjo4LBa7k1/RIlp1L4T2mNArRM501q5xbpP2ApSTkRAgu6EXPSoQS9KqRZWlcj
         fOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=taeI4zZYBRlKvHCehSw5hhGxCvqYCUSI5+8Jldlhf6A=;
        b=bdhTqL4FWQnC4TMz5vv5BmUbKR83E1FIWifYJqHrDpp8XfjN/gZiCXdpxzr2sfb0vT
         Gz7oF56rIWn/WrZMQlG13BPCMHTzEeEC9stSWU0Gx1LD3HxbMLewrkdngxRqPiJ9KBep
         05klFQa0qvg9ryA+IG/MXc4GCeEjME8r2VIE2EOIFY84izT7eSs4+5ePeuJHUJWkjEyR
         0R0E7hpKSgE9Z2X+2bPwqsbs69GHvLxvg3m2hKHmC3cY6X+dd6gX+kQc/ucx4r1qiFX5
         ffLl2bH/un4O/DxqN77Ppb787U1v7/v0BA6Go9/4O0K8jJjTsQOKlJ2q5aqAsy/MgIt8
         Dx8w==
X-Gm-Message-State: APjAAAVKkbKWU9qZOrbXHSZj937a+WryjlvDq4d0f7ZCD8MvvH3UFzKe
        6HO1uvxvyE0Ddwd1bMJtCxpT21Xpqe5NOCXkuRt7fLg2oCnbQg==
X-Google-Smtp-Source: APXvYqye66e615GzK6uaMcehUaJsRCDP8T+ZxH9P9jL6neejVvlKgvmnp/zss+AEYi/R+p9ksZ+d9IPNuAjPM376Lg8=
X-Received: by 2002:adf:dd01:: with SMTP id a1mr24857607wrm.12.1566867358474;
 Mon, 26 Aug 2019 17:55:58 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 26 Aug 2019 18:55:47 -0600
Message-ID: <CAJCQCtRtJ5LjO4vseJCP1zANF7dbjDtcsnoTTNs5YAmHt=NWRw@mail.gmail.com>
Subject: Btrfs wiki, add Parrot as production user
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

https://blog.parrotlinux.org/parrot-4-4-release-notes/

Looks like they switched to Btrfs by default for / and /home.

I think they should be listed on
https://btrfs.wiki.kernel.org/index.php/Production_Users



-- 
Chris Murphy
