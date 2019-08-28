Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFED8A053B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfH1OpY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 10:45:24 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54392 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1OpY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:45:24 -0400
Received: by mail-wm1-f46.google.com with SMTP id t6so336807wmj.4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0BEjoSTlcGLs2tsgn7jxrftr6eID5J8qKRsTkVEr2Ik=;
        b=FCjQEBemcCYcDekTz6INAJldaLnmQZBj9I14J8OFey8wLaIcoh+uIDe1Ka8T2XKhLz
         Ca6H0RRU0VjcSU1RD5FlLOvE7Mc6gRRo/4PvUSpEORBuat3DMfwDSgX2RQUFGXG2iXMw
         rycbM1brxncwN9zN4Xmi1NTV2b3WQ+KtQ4WVeYzJIANXZbIankO0TgeRUo0HdFXzohme
         yPX+HyBL1XSwexk7hM2kXKZpVkdAlsAh1Y/SrobpuZ1UojBkPgKp4m2vgblAQple1nnI
         GSeD95jIHQDnG+T1nzeNlW9PFKb8BOG8Jx+boBhegaS8L+8sr75VGg9BsuvV1FPON/RY
         rBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0BEjoSTlcGLs2tsgn7jxrftr6eID5J8qKRsTkVEr2Ik=;
        b=sfV6h4GkvOTDIhDXp2ArBC2TVQr2qOz+eiX/iHeRpIBLFVwvPb2p0dPX1SC9X/lf0V
         R62oppNA/RD0jJxNSdR3xi60xBp+9LaAQ5Do+jbIqxExS+Q9ozWDU/lOoEYC8GjNqJsG
         cjvYkNiH9sHgrpx8mNPV98YJUq4BWTK1moT6Q0S5csrMPhyh3H4tk0PYt5sWLfN475F7
         yA4SUIDOjCsViFtUt7lc+37E/aXIo9h8yIiE5tuev0BG29mJIoGeimawWr+PNP3Cn8VO
         B5Xw7d/+YiQGkB3qygFqHEzSQVJyTS/Tea4pj3ZucYkDTzfuZXYZCz8UzzsOCcPMxuk/
         xJiw==
X-Gm-Message-State: APjAAAU3Z1kIeWfSAkVOWEg6Dd9BiWXgTnzk04ydrcbJpm6mIN1xj9jQ
        YGl9+i31CcpOXAcNh7FBmrl039x7
X-Google-Smtp-Source: APXvYqw3BaEiK+Hbsv1SbPSJJzRm+yNKKvHyV12CQc3vpsB9ve/m6Xbf26OPegeW2Puh4N7mZe+6VQ==
X-Received: by 2002:a7b:c241:: with SMTP id b1mr5499196wmj.165.1567003521576;
        Wed, 28 Aug 2019 07:45:21 -0700 (PDT)
Received: from [10.19.90.60] ([193.16.224.12])
        by smtp.gmail.com with ESMTPSA id i5sm3588613wrn.48.2019.08.28.07.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:45:20 -0700 (PDT)
Subject: Re: No files in snapshot
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
From:   Thomas Schneider <74cmonty@gmail.com>
Message-ID: <f22229eb-ab68-fecb-f10a-6e40c0b0e1ef@gmail.com>
Date:   Wed, 28 Aug 2019 16:45:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I was thinking of this, too. But it does not apply.
root@ld5507:~# btrfs su list -to /var/lib
ID      gen     top level       path
--      ---     ---------       ----
root@ld5507:~# btrfs su list -to /var
ID      gen     top level       path
--      ---     ---------       ----

And there are files in other directories:
root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/mgr/ceph-ld5507/
insgesamt 4
-rw-r--r-- 1 ceph ceph 61 Mai 28 14:33 keyring

root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/mon/ceph-ld5507/
insgesamt 12
-rw------- 1 ceph ceph  77 Mai 28 14:33 keyring
-rw-r--r-- 1 ceph ceph   8 Mai 28 14:33 kv_backend
-rw-r--r-- 1 ceph ceph   3 Aug 23 09:41 min_mon_release
drwxr-xr-x 1 ceph ceph 244 Aug 26 18:37 store.db

Only this directories 
/.snapshots/158/snapshot/var/lib/ceph/osd/ceph-<id>/ are empty:
root@ld5507:~# ls -l /.snapshots/158/snapshot/var/lib/ceph/osd/ceph-219/
insgesamt 0

To create a snapshot I run this command:
snapper create --type single --description "validate 
/var/lib/ceph/osd/ceph-<n>"



Am 28.08.2019 um 00:24 schrieb Chris Murphy:
> On Tue, Aug 27, 2019 at 3:33 AM Thomas Schneider <74cmonty@gmail.com> wrote:
>> However, I run into an issue and need to restore various files.
>>
>> I thought that I could simply take the files from a snapshot created before.
>> However, the files required don't exist in any snapshot!
>>
>> Therefore I have created a new snapshot manually to verify if the files
>> will be included, but there's nothing.
> Snapshots are not recursive on Btrfs. The snapshot will not extend
> into nested subvolumes. Check to see if you are snapshotting the
> proper subvolume.
>
> # btrfs sub list -to /var/lib
> # btrfs sub list -to /var/
>
> In some sense these are redundant, I'm not sure if your /var/lib is a
> subvolume or not. Also please include the exact snapshot command
> you're making.
>

