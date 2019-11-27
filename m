Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC44210B105
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 15:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK0OTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 09:19:13 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39382 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0OTN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 09:19:13 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so16120378qtj.6
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 06:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m7sPx6RDJTXls5RJ8bNyu+RaoRvgjGfeNpFkWxyhW3Q=;
        b=FLBGcmc5f+rhQcdOCXdpN5AzKtE+J3ic8V+WW3OtcEPFpIj+pJ4nYDFf6aGxGN+Rqw
         cY/D8IG8F0cFl+HhzZzgwUFAOCvlFhZdCtW5T90jjQHqIlvkY5YHfIvAx2TMZi2Cwwjm
         0wfsDtwd4Q10wOb1Q2T/dfZ3A2yIHtUsKZFlig0uI56EQ0hzknRjc9eFTjGpxe2tTLIt
         4H5VS++pwa69LedUfJmB4ZvjnrOYcsFSRNcmrMNcEkwYRjm/EDzIeeWErQfauNuV9dOb
         pP2+BrSgzdn4J4Du/lTytoFacr27RlyoUwjI0HPfwmqS6vBJ/ap+aYB3or9S1QtyZjsc
         d15A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m7sPx6RDJTXls5RJ8bNyu+RaoRvgjGfeNpFkWxyhW3Q=;
        b=S7PTzYfLDDEri7VKAyD03r2xYK3Fc5rmF73r/5ONrwH22ekwRc8iCAf8mqACAuimsh
         sz+EHmRJyxfjhHByAycdolHGLdP4fcItPuR3rOC5PqcplgyN0AVXGe5zslpZLmnOFi1c
         onNSo1j8EWSJ/Ps8hRIV/t4OSsj5WKp+jTVkLeouI3YovRH2eBk36pmkoarCFzZM1OP8
         XH/LD1QnvzFpElEX8xqu7uS9G4QE2hyeCofvotzCWvea9gpl1m/kdTjsakYtPDfRVEMB
         NTIzc5HGeQ1yP6ygyLc+rFP9g3NrlLSXEe8jqyHkeGyCizJwpGQFZBX3hFRqbnWKfU62
         8gjw==
X-Gm-Message-State: APjAAAW8w0oZTDbxYNplgK/9fEuVvwXVN3MCYsUebsFWHeVZqOqEHEA/
        KYZDdscRClaN+cM+1XeI2FikkedpZM8=
X-Google-Smtp-Source: APXvYqwcy1Eljug5AzRhVP2rUkSVs4/jqeEhMOae9BHVTyyAiEAqz1Zhw5zDFH4tTLjm+4iTVcpJsA==
X-Received: by 2002:aed:24d9:: with SMTP id u25mr41162559qtc.229.1574864349900;
        Wed, 27 Nov 2019 06:19:09 -0800 (PST)
Received: from [192.168.255.200] (user-12l2ihc.cable.mindspring.com. [69.81.74.44])
        by smtp.gmail.com with ESMTPSA id f6sm6885055qkk.12.2019.11.27.06.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:19:09 -0800 (PST)
Subject: Re: Slow performance with Btrfs RAID 10 with a failed disk
To:     Christopher Baines <mail@cbaines.net>, linux-btrfs@vger.kernel.org
References: <8736e9g1gb.fsf@cbaines.net>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <1ac24ca2-4f78-13a8-0b06-8970e8ba6e17@gmail.com>
Date:   Wed, 27 Nov 2019 09:19:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8736e9g1gb.fsf@cbaines.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-11-27 03:36, Christopher Baines wrote:
> Hey,
> 
> I'm using RAID 10, and one of the disks has recently failed [1], and I'm
> seeing plenty of warning and errors in the dmesg output [2].
> 
> What kind of performance should be expected from Btrfs when a disk has
> failed? [3] At the moment, the system seems very slow. One contributing
> factor may be that all the logging that Btrfs is generating is being
> written to the btrfs filesystem that's degraded, probably causing more
> log messages to be produced.
> 
> I guess that replacing the failed disk is the long term solution to get
> the filesystem back in to proper operation, but is there anything else
> that can be done to get it back operating until then?
> 
> Also, is there anything that can stop btrfs logging so much about the
> failures, now that I know that a disk has failed?
You can solve both problems by replacing the disc, or if possible, just 
removing it from the array. You should, in theory, be able to convert to 
regular raid1 and then remove the failed disc, though it will likely 
take a while. Given your output below, I'd actually drop /dev/sdb as 
well, and look at replacing both with a single 1TB disc like your other 
three.

The issue here is that BTRFS doesn't see the disc as failed, so it keeps 
trying to access it. That's what's slowing things down (because it 
eventually times out on the access attempt) and why it's logging so much 
(because BTRFS logs every IO error it encounters (like it should)).
> 
> Thanks,
> 
> Chris
> 
> 
> 1:
> Nov 26 19:20:56 localhost vmunix: [5117520.484302] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
> Nov 26 19:20:56 localhost vmunix: [5117520.525506] sd 0:1:0:5: [sdf] tag#360 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Nov 26 19:20:56 localhost vmunix: [5117520.525525] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=24384, sector_sz=512)
> Nov 26 19:20:56 localhost vmunix: [5117520.566649] sd 0:1:0:5: [sdf] tag#360 Sense Key : Hardware Error [current]
> Nov 26 19:20:57 localhost vmunix: [5117520.597829] sd 0:1:0:5: [sdf] tag#363 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> Nov 26 19:20:57 localhost vmunix: [5117520.637610] sd 0:1:0:5: [sdf] tag#360 Add. Sense: Logical unit failure
> Nov 26 19:20:57 localhost vmunix: [5117520.668134] sd 0:1:0:5: [sdf] tag#363 Sense Key : Hardware Error [current]
> Nov 26 19:20:57 localhost vmunix: [5117520.668136] sd 0:1:0:5: [sdf] tag#363 Add. Sense: Logical unit failure
> Nov 26 19:20:58 localhost vmunix: [5117520.707347] sd 0:1:0:5: [sdf] tag#360 CDB: Write(10) 2a 00 46 86 12 00 00 00 80 00
> Nov 26 19:20:58 localhost vmunix: [5117520.736962] sd 0:1:0:5: [sdf] tag#363 CDB: Write(10) 2a 00 47 1e 0e 00 00 02 00 00
> Nov 26 19:20:58 localhost vmunix: [5117520.774569] print_req_error: critical target error, dev sdf, sector 1183191552 flags 100001
> Nov 26 19:20:59 localhost vmunix: [5117520.774573] BTRFS error (device sda3): bdev /dev/sdf errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
> Nov 26 19:20:59 localhost vmunix: [5117520.803740] print_req_error: critical target error, dev sdf, sector 1193152000 flags 4001
> Nov 26 19:20:59 localhost vmunix: [5117520.803746] BTRFS error (device sda3): bdev /dev/sdf errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
> Nov 26 19:20:59 localhost vmunix: [5117520.840559] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
> Nov 26 19:20:59 localhost vmunix: [5117520.868966] BTRFS error (device sda3): bdev /dev/sdf errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
> Nov 26 19:21:00 localhost vmunix: [5117520.869037] sd 0:1:0:5: [sdf] Unaligned partial completion (resid=52, sector_sz=512)
> Nov 26 19:21:00 localhost vmunix: [5117520.869042] sd 0:1:0:5: [sdf] tag#385 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
> 
> 2:
> [5168107.359619] BTRFS error (device sda3): error writing primary super block to device 6
> [5168107.932712] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
> [5168108.091827] BTRFS error (device sda3): error writing primary super block to device 6
> [5168108.155217] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
> [5168108.288296] BTRFS error (device sda3): error writing primary super block to device 6
> [5168108.972431] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
> [5168109.204083] BTRFS error (device sda3): error writing primary super block to device 6
> [5168109.595413] btrfs_dev_stat_print_on_error: 296 callbacks suppressed
> [5168109.595422] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071725, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.639670] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071726, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.664981] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071727, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.689197] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071728, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.728189] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071729, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.744894] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071730, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.755457] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071731, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.831763] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
> [5168109.848128] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071732, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.849445] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071733, rd 408586, flush 0, corrupt 0, gen 0
> [5168109.917277] BTRFS error (device sda3): error writing primary super block to device 6
> [5168109.941132] BTRFS error (device sda3): bdev /dev/sdf errs: wr 5071734, rd 408586, flush 0, corrupt 0, gen 0
> [5168110.009785] BTRFS warning (device sda3): lost page write due to IO error on /dev/sdf
> 
> 3:
> Label: none  uuid: 620115c7-89c7-4d79-a0bb-4957057d9991
> 	Total devices 6 FS bytes used 1.08TiB
> 	devid    1 size 72.70GiB used 72.70GiB path /dev/sda3
> 	devid    2 size 72.70GiB used 72.70GiB path /dev/sdb3
> 	devid    3 size 931.48GiB used 555.73GiB path /dev/sdc
> 	devid    4 size 931.48GiB used 555.73GiB path /dev/sdd
> 	devid    5 size 931.48GiB used 555.73GiB path /dev/sde
> 	*** Some devices missing
> 

