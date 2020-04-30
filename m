Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870E01C08A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 22:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD3U6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726336AbgD3U6w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 16:58:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4BC035494
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 13:58:52 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x77so499036pfc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Apr 2020 13:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fozNdG/i+1qLIso2/b4dwTRBx44Nb0bqDoxRZkd2pZ8=;
        b=Ams5YpK4Wl0X+gZ3uX7AtR1NsV0d07EsokK8HyknmaKPBcSOeGmTkp3BNHJojL/jhn
         t9FJvOUzKuRj+sQbxoNeIvMjmtBDXP25k7Ys8z+FP3JeTCCGmZhlv39JdBr8IKHdMZZw
         2klfZmwIOb2KETdIpjI1egrEx/M2dxxw667oUD4Yn7ZUN9Vfr7f4hFT+uOY5JE+6NewP
         /0O2C4/0GDMIhSpt/XtPIdurGa9qsDLBhj5RlRfTgCzwEKFYEGoEpX/XHcPOKgq7MJev
         wALRhesUPtCJBIGBOJyl92WpjyzH/kf1viAhjrd9ujptffGcKZwgi+mGH8mul/jlcxpR
         WC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=fozNdG/i+1qLIso2/b4dwTRBx44Nb0bqDoxRZkd2pZ8=;
        b=sjPuvonsgwqeVSDfuwKjW34HQfM2ffF58zs2Dcwj2vIaCe2EM/Awq2et3Tx8pLDbrF
         pxo6CER3cbVAWmTtG+2AIgVUuP4pqLqXqHraSI8qe7Pn1Xk/FGj7LLv567qlm4+rVk/N
         1bse9NTbYpDAyBnnAPgIXbhl989jgV5RXwcGu65wU5EaYRyCrq+6xTsctYVyvgsHiAAU
         7FAPOcKOOJ9TGxYoYxfm57xa8E2YFiJ+ZW7ADDBjSYnVuA0tnJSe8Hc0Pva/PIdYKg5Z
         2e2vJ8OnrlafByO9KVA1qGMLnRHbz3anVN3gawnU2nRoB98RpgXhQPJBrDGnthNAwPW5
         C5rQ==
X-Gm-Message-State: AGi0PuZc9onm7b8eAccigI9OlWtgKfuQ1CYvTJlz0IolHKDCMmn1rUHf
        IjHIvifzcHdowuDAKOYuxjAzt69nFthCUQ==
X-Google-Smtp-Source: APiQypJPkk82PcSnZqytn3CQOLBLMTDxEl6LxZ3hK10B8mJq5yToaFuPJR3MsFYpQfx5f/zcbtdijg==
X-Received: by 2002:a63:7b4e:: with SMTP id k14mr789915pgn.267.1588280331540;
        Thu, 30 Apr 2020 13:58:51 -0700 (PDT)
Received: from selma.local ([2605:e000:1c0e:43f7:85d2:c317:ef64:6afd])
        by smtp.gmail.com with ESMTPSA id a16sm577484pff.41.2020.04.30.13.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:58:50 -0700 (PDT)
To:     Alexandru Dordea <alex@dordea.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net>
 <CAJCQCtQqdk3FAyc27PoyTXZkhcmvgDwt=oCR7Yw3yuqeOkr2oA@mail.gmail.com>
 <bfa161e9-7389-6a83-edee-2c3adbcc7bda@ka9q.net>
 <848D59AB-5B64-4C32-BE21-7BC8A8B9821E@dordea.net>
From:   Phil Karn <karn@ka9q.net>
Autocrypt: addr=karn@ka9q.net; keydata=
 mQENBEw2mJ4BCADELiPsLFHDwapoSU7d2xNHxmwzzrFUCZWhO34kM6G5+o9GUNmGgMQ0BmXp
 I6hx77HHnrj9FC6kWh/bxBt3+o8HW+NTWzJSvf6kW7ThaNt7v9iewkS23JOMarAZs4qy6MhT
 1RW1/yWY7RimWxrmkKPTKKa0Ad4CWT6fcP3t+doqGslSQIeoTh0C33ZT+LY59Wcr224iXohN
 4Uu/nFe4yAHjtA+4Sesveo3Tyi8cbOgkcO6vij+pXesCcuhtGMlnE2dxRqbenrfVGLUVxNug
 LkQdLWezaGGm+dcjWYk1xjtaDnsCpVaYCMsfYNADQPJAjAFu37pVdoXhseVXfzOUN2EXABEB
 AAG0GVBoaWwgS2FybiA8a2FybkBrYTlxLm5ldD6JATgEEwECACIFAkw2mJ4CGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAAAoJEPFOQ1TtRjRGU98H/Atsb/N4lNbzNdzdIRcHD9XgCEa1
 UdR4mxgjwvLxS1nYRNdHwfTxvA5nxWfMx/0CB26VaNFdI3lkg/S0vYsSUu6M7l8Zb8v4JMyU
 4B4yvkFHZ3II5oilzIMa3e2cMfDz7TSwO1JcXyI5y9vHnvH65/LQF+QojDgzf3vXKiNdTXJp
 3nEa5IgMAB0rcSNsXFx8xbHi8s5niL9+1I7XTPvVMeXrMe8h4AG1nM/dK96WwmV+tLyXKYXn
 xVeb9F4X9CNQbkn/xAH+egvKHHT3V7K9cAhrDfu9Qwpo7zKk/akBpLWG2kmkTOfhXjm3UQhv
 MVgDmpeQIYa1HgAsKrsDQMzrIFm5AQ0ETDaYngEIAJmFdm0MmENzLEosD1FvGPJleWDYb0ah
 8dOk4XUug1RhW40f7AsugT75pKs9PolXt92920GdU727X3Jpgdj4kLDtIQA0KZrOXiEOZjIZ
 WcROAyvTGyMs/P7Um1AGNM161Ga6/Wtlc076FN7EUQtzPbthH26M3lGWUX0Ccls/8Ep4qbnF
 IrMRBxjaxKbqfKPTeU10pDykzA7s5hiNe7qaegvqD6YLseZ+6FqCn988YnLiIaFeNbWxUY5G
 spjAsfesnAmpn5vhUqAGiizkNlAMIN31xvpLd93oM4/vORszIuN1UP2RlxL3s30BncZl2XOd
 Mk1/59Sy70zVqF1ANyMrA18AEQEAAYkBHwQYAQIACQUCTDaYngIbDAAKCRDxTkNU7UY0Rszt
 B/9ZPH9xw47lPkVJRbhgf0G7fdsxsyiuouAqOKklUNFSy4+qeGomjwE6YvdMybwGtaUGla7t
 2mDzrva+7Gzb0inXIgmahQPmM16F3GVxGoFL+QJ+7gD8Hco6e0/2kju7ZREDE7SOEwKb3lhD
 eNLccfX2AqAHfCT/LVLbgBpMRmwUJQThM+33Z2L9BqIM3awj2mOTmeDumpxiDfroU90mGc9c
 pXe4YrNIkL/N8eMzLe1bpu+mpPCiIrEO+dFA7N8jjVcOCQ4Lr8sU6cOsEdkaACZiNFKT99eb
 NkKigK8sEkDZc/AKhPCEsnaZpwBZPScOL88LLi7FHj9Osznt+uhWfbLe
Subject: Re: Extremely slow device removals
Message-ID: <de1c1b3e-09ac-bdc8-c2fe-d95c2bffb766@ka9q.net>
Date:   Thu, 30 Apr 2020 13:58:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <848D59AB-5B64-4C32-BE21-7BC8A8B9821E@dordea.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 13:27, Alexandru Dordea wrote:
> Hello,
>
> I=E2=80=99m encountering the same issue with Raid6 for months :)
> I have a BTRFS raid6 with 15x8TB HDD=E2=80=99s and 5 x 14TB. One of the=
 15 x 8TB crashed. I have removed the faulty drive and if I=E2=80=99m run=
ning the delete missing command the sys-load is increasing and to recover=
 6.66TB will take few months. After 5 days of running the missing data de=
creased to -6.10.
> During this period the drivers are almost 100% and the R/W performance =
is degraded with more than 95%.
I see I have company, and that a more recent kernel has the same problem.=

>
> The R/W performance is not impacted if the process of delete/balance is=
 not running. (Don=E2=80=99t know if running balance on a single CPU with=
out multithread is a feature or a bug but it's a shame that the process i=
s keeping only one CPU out of 48 at 100%).

I'm using RAID-1 rather than 6, but for me there's very little CPU
consumption. Nor would I expect there to be, since the work is all in
the copying. I have 8 cores and am running Folding at Home (Covid-19
drug discovery) on 6 of them, but there seems to be plenty of CPU
available; idle time is consistently 12-15%. Still, I tried pausing FAH.
There was no discernable effect on the btrfs remove/copy operation, nor
would I expect there to be since FAH is entirely CPU-bound and the
remove/copy is entirely I/O bound. The 'btrfs remove' command uses
relatively little CPU and always shows as waiting on disk in the 'top'
command. Same for the kernel worker threads.

But just in case, I've scaled FAH back to 3 threads to see what happens.

I'm thinking maybe it's time to go back to dm-raid for RAID-1 and keep
btrfs only for its snapshot feature. Integrating RAID into the file
system seemed like a really good idea at the time, but snapshots alone
are still worth it.

When I ran XFS above dm-raid1, I'd periodically pull one drive, put it
in the safe, replace it with a blank drive and let it rebuild. This gave
me a full image backup, and the rebuild copy went at full disk speed
though it did have to copy unused disk. But based on what I'm seeing
now, that's preferable. A full disk image copy at sequential disk speed
is still much faster than copying only the used blocks in semi-random
order and shaking the hell out of my drives.

I wonder if putting bcache and a SSD between btrfs and my drives would
help...? How about a few hundred GB of RAM (I have only 12)?

--Phil



