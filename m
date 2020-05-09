Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E81CBEAF
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgEIICw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 04:02:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:48819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgEIICw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 04:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589011361;
        bh=ho2DkvdPIoET5xzHXN1UveI3F6NlUNKIuqTMmyCMIDU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:In-reply-to:Date;
        b=Dkh4S32H7HBEXMNPmCH4bnuwYYbDnSlu9UNBfVT+dfUkNBI2lC0gbay1KliJFxQIC
         jmzAaou13EwyVXmE+6z8+6MIszLEwttld+LeOdBwk/i7g15qjbh67OTatsBeIhQBfR
         wjk3dUTrQORpxyUwQSdbw/eg3ktmuOqR9cGSiTos=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from nas ([34.92.246.95]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1jkCM83ZvH-00MvAe; Sat, 09
 May 2020 10:02:41 +0200
From:   Su Yue <Damenly_Su@gmx.com>
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs-progs reports nonsense scrub status
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au>
 <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au>
 <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au>
 <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au>
 <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au>
 <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au>
 <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au>
 <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
User-agent: mu4e 1.2.0; emacs 26.3
In-reply-to: <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
Date:   Sat, 09 May 2020 16:02:31 +0800
Message-ID: <mu6h7cyw.fsf@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Provags-ID: V03:K1:I+r+wCmWKjEuVtJU3FfWtpSUTFhJJ3RKmVVXc8tiv101U1Xwz8p
 Ybbq66Aaf7/9OeoNb9DoBv90U3Ow5YErFkCZfxo4EKxaToms+5Tu+NtwWPDG8IcWwdD4Ntw
 T21nao0t0Q5BHZqrp1zciuLLuBFMR6d2ZJJx0upEHNjjMMwUjMiaVs2x4ediBqGDJ3jWJ6C
 4DJa5ugYFPN83yFYB60PQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RVNgaufpOUs=:7jnctKpGPnda4LdW8hdJDe
 L5RG3KK8DdXX8zGUQW1QYYIJZs6i7+6t+p440WK55QLK3hwCyPqBpKanY92RqcugmnGppOmsw
 CdzA0ObytaopS+mpZwjxvwWavrFU1rqCtCk/7KpbcYIzoeDkhDD9F/5s2Np0ehRF1ktk1kb/n
 Ebs2oRbcP3KrIRO3v9pPVqFnn9RTOOY0TW6HDacJ4cMezHtFNLesDilki6Rq3tjvypNb4xTHB
 xILmvzdKAjsAOhU/chEeudjnDE4eMBBmbX6j5RmSogt/DiCoYdDmtUBH8CfSMkVLdu4O0e3mi
 QqmLOrKtV0Y0SmEj++XQQPiK9ZRbhQx17hPluTpvMPnq/azuHYFcCGeuO1Yc+r1G4IoBwDkBy
 QoixIF43NnkjYJGG0GYw7sYfQ0/U4JdTaDrxLRuDjF7aTB4fqrw55LA9ERkYVYc+XD+Qtmu+9
 41aHKKHb5/HcSaid85bfQWUT79I6nCOr190E7EE9T0XR1q5SOPZURC8H/MUn8ERIunPngWGd8
 WuEl7Gj3a6v352AY2zuRZ/tsvm9knjR0FHqSjrWKrgIVqjU8xFbNA7QGsCtd/U/36vKAeY+92
 PBnI2/ZnloaKGoSnYh7qeXsAxw1Nt7gtw0NR49wF9pijaR9MqKubr300Z8TMooplBwdumTkd0
 NjEhA/yktQjVpK28fcKmV9dLT/aEw9FCBbRv+T4Cp1yB3o7CegIeb09lrDBrmAFFTRYst3B4v
 RALYA4BLNSqxlssYRQ8i8i35VqYR6jtqOblY+obrC1h3D5yy7Uqlx1H9FIJ6XXKdSgB19Mg1X
 U5or8zdcHm85ca0d2GpKF48bKzZvCGhUced6e90Myo6bUabSGlIKFA5k6crAABLIQ+DMzdkz3
 8X+cjpg8sxsexA5lGSKYEzuFHXz62ZYeQXEc1d2gwagcdo8SGSKzS0vhibG/Dm38Qsmo7oUpx
 my9rzX1pr0PqKnHmG8AXnKG6wdV/D/AO6bnqSohN0ayuK2iQOQXd37gKP1eajCSJ94CR4TbYQ
 WJL+IyG0SeKAlkzk4JjG4UvLhUHR4rbJ8yFD7UD1kpePhrBdR0qyULznrpa7TyvDcTI+jkaTG
 WhHGOe17YFD1tmrUTlxx7guXTEV9+Yzz2BZcpejBNQj2EiaxB9g055X7fsCIyEhdGExJZ4lFQ
 6Wpwz7EsTzaIxx0w1kT1cXHGqjzh5dlA/vkAMrt1GM9BPCpQkuzwJN0KXB0P6Tqo370ppkW7r
 TN6bXJbF25DkH1vz8
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sat 09 May 2020 at 01:06, Andrew Pam <andrew@sericyb.com.au>
wrote:

> And here we are again:
>
> $ sudo btrfs scrub status -d /home UUID:
> 85069ce9-be06-4c92-b8c1-8a0f685e43c6 scrub device /dev/sda (id
> 1) status Scrub resumed:    Sat May  9 02:52:12 2020 Status:
> running Duration:         7:02:55 Time left:
> 32261372:31:39 ETA:              Fri Sep 17 23:35:41 5700 Total
> to scrub:   3.66TiB Bytes scrubbed:   3.67TiB Rate:
> 151.47MiB/s Error summary:    no errors found scrub device
> /dev/sdb (id 2) status Scrub resumed:    Sat May  9 02:52:12
> 2020 Status:           running Duration:         7:02:59 Time
> left:        31973655:40:34 ETA:              Mon Nov 21
> 19:44:36 5667 Total to scrub:   3.66TiB Bytes scrubbed:
> 3.70TiB Rate:             152.83MiB/s Error summary:    no
> errors found
>

Weird. Any operation was done since the last "interrupted" status?
Does iotop show any actual io of the two devices?

=2D-
Su
> I tried building btrfs-progs v5.6.1 from source, but it gives exactly
> the same results.
>
> Cheers,
> 	Andrew

