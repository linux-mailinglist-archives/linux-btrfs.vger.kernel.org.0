Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3052A7F3F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 11:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfIDJY1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 05:24:27 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37009 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfIDJY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 05:24:27 -0400
Received: by mail-wm1-f43.google.com with SMTP id r195so2780921wme.2
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Sep 2019 02:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zoarTvLv9Yo2UvKO7hOkiz6yho8U/lNrsl7k0570wUE=;
        b=h7rsGJcB8VoWT7XGpppLcx97OckGLepeFA+wK2UwIVEv1JHwdN4Pb+Q4pZVmczr96W
         I05HNCuaGlfmAiZ5gj/8WrpWfFKiy8zVG/okculdf8Iyj97CPJGiNvHylPpMrKLeBFgW
         5lDnCLEPZm2bZJTDX38A5YUmZwmkvHbC4SH8eCiykSNm3qdN3PeVi9cpTmiqmcGgCtBH
         5Dceiin49DtWgJ0m2xLkje7y7fhK99AwDjRV0KWZszDJBhK5GFCcywOKzU9Xm9OSmplD
         FSOrCFT6q9w7HXJlEPow3bNZwcyih7rVyz6zu8XjqJEMFNnhs+0e7+V4APjJ09sSRytR
         mOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zoarTvLv9Yo2UvKO7hOkiz6yho8U/lNrsl7k0570wUE=;
        b=L6PoO17/X1OBlLprVQjz2NaVHyMO7JH8Fs50Rud3yQYFg8c+ZpUGf3i7cxzQ5RrBfr
         OR8C+JJzrPaddWNLAQrBkbtihPebEJ5O64KwxFCbsMu6C/mhK0FKsvlKZDSLqsOI07wb
         snF9RWrT5B7U5znpsAQSekzJAQ3PnZGNuLy2Y/RDSJbwL8bQj8k2b++aInDtdDdJzFpd
         kF9ErzVZIqhPL8u5M2Wl0uL8f0RgyPPZ5i3JrBcAyJOyc4PKucWm5RDVtTU9qc2oKka8
         WA1ceqSvHkYUqvThukKpaFy7E5O+pkApcR138DsFjj0CAFqKq0Nf4egX24UmAL9Q9VrJ
         W8cg==
X-Gm-Message-State: APjAAAUx4u5RtztSdiWiesQ4ndAOS7+n5KUbFAV12wGeHO/SbsDlOyvP
        0+XL7UV40sVMMuOrjJ4hVqFM7b6N
X-Google-Smtp-Source: APXvYqybj1mdRT77KPlnCcsz/bkjM31zi/ELgoiDMCCcoa8nwCbxrGN1Za4p42iAIOuPdhGhNumafA==
X-Received: by 2002:a05:600c:2181:: with SMTP id e1mr3468845wme.117.1567589064533;
        Wed, 04 Sep 2019 02:24:24 -0700 (PDT)
Received: from [10.19.90.60] ([193.16.224.12])
        by smtp.gmail.com with ESMTPSA id b1sm2496199wmj.4.2019.09.04.02.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 02:24:23 -0700 (PDT)
From:   Thomas Schneider <74cmonty@gmail.com>
Subject: Re: No files in snapshot
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <b729e524-3c63-cf90-7115-02dcf2fda003@gmail.com>
 <CAJCQCtTs4jBw_mz3PqfMAhuHci+UxjtMNYD7U4LJtCoZxgUdCg@mail.gmail.com>
Message-ID: <2ba86d8c-8849-eb61-5d9d-dfe024e13127@gmail.com>
Date:   Wed, 4 Sep 2019 11:24:22 +0200
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

Can you share any update on this issue?

-------------------------------

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
> On Tue, Aug 27, 2019 at 3:33 AM Thomas Schneider <74cmonty@gmail.com> 
> wrote:
>> However, I run into an issue and need to restore various files.
>>
>> I thought that I could simply take the files from a snapshot created 
>> before.
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


