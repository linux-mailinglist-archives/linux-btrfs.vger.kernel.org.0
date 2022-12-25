Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A602655CB0
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Dec 2022 09:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiLYIyb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Dec 2022 03:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiLYIya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Dec 2022 03:54:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62196305
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Dec 2022 00:54:26 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MPGRp-1pUbzZ0j6r-00PfQe; Sun, 25
 Dec 2022 09:54:24 +0100
Message-ID: <c83fec0e-e4f4-b520-4b6f-f3c24c3f0ba5@gmx.com>
Date:   Sun, 25 Dec 2022 16:54:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Is btrfs dying after removing many snapshots?
Content-Language: en-US
To:     Jakub Wasielewski <scyld@gazeta.pl>, linux-btrfs@vger.kernel.org
References: <05b8b042a6543e853d7e1df98c550dc11b5a0c07.camel@gazeta.pl>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <05b8b042a6543e853d7e1df98c550dc11b5a0c07.camel@gazeta.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XWXf8rGm14rLmEFDpmN2gZ7qsd3jB54DLsbQjqjt7MqOXTc8Epe
 xWNKfmrI8SfSGCYP9XXI5zn6r743EjoB9E4EvtJf/f8T+7LBpgMLxT3EOZiz1UKqh1St9wv
 zK4IpfkZMyfx5lkQ6nUFL70acT8924rhpvrAHcLr1bXWJnI4P/glY7pBkrqx2s7sNW4GjlB
 JCZ81COlZ/lZPszDm/0Dw==
UI-OutboundReport: notjunk:1;M01:P0:1gRSjbMYRRY=;cIgsH5JKKGiQPvZ6BrnHZWs2lWg
 CwB07ZLzKcx/97xqU3R5f80vmjaQpd2/PvsPFmQ3wu0WMsEkVNWtvlXngFT2HxHyQFRhMg0zi
 OmREbxhPU9MYQKIRU+vmdB7WX4T1xDOHxdLUlcEh0XR1OaE0X3P/lbLeS9qxh1QhTfLGKyknl
 iMkVVV5wnLjQZoBSvdy0ZTSxVnWOO3LUd+W3A3pHEk+JKnPBPUtJoPi5hf6ssoNudtJ0EIxjJ
 TXQg7wNyIDBVsGdmnAbkSGx9yOTjnee/0VxZcyCrEcbXR09R6Ml/w7ACDGZY0KBsVh8R71hZU
 5GkK5r1zMY4Yox1eskGcwugVGU/eZ7+YyN/yvD1GTpclq9VZthcnjmd92P9DEJAYM3TFo14Oz
 DgZJ3ml5iQPvwbkvAfrVQW3O0Zy1BmIIuwQnL0s1Nxl6gP0oeQZGRv1M7GwHnqT/clIY0rkaZ
 MjZOLS27OoIGYVn4yxMm+f4MGiMJTog5PZMRrl0inQj+uBibwJIwDinh78nyUUsJKpSVVY4wl
 adcsJzf4txfDRszmyV2x8YwYaNORJBsPMdimg+DEoVIpHtTnH5vVrpMZshFrMvBmQ2KhnU4RQ
 wXdUb7OKlcMvJwJFcIAArFRmJ4mfVmudNBlSQUz4VCzWIfENxF3AMKGR40eXPZ9jGdA9D3nP7
 gpzc0AqbUpy/1V3wzDVXMxYEn8box96m9j46gFM65vhTxlwyuVvVwHzI5IZ1izOsA6mTf4jJC
 gA8UWnWMQgSS7kyVUV4lsTXvKtgPlVJH93GDILvrp2W5YMRzJQbFYA6hpbZTyDo91fLWbQ5Lv
 wGiqvXDEvAvkhB2DJ98Spb0Tt/FJDFwgT90UCX0yASw5HpW9vx0aU+nivY5GZ5RZjt7Tgn7yy
 VMOBMNh3gx6p+FFg920OZEFSxZft5oS8uwpRFiywC4vYHT4MaBK0aB5dPELR6Z5a0PGLM9oII
 Gevb82vNff4ICnnGn3WmwLX4MP0=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/25 16:43, Jakub Wasielewski wrote:
> Hello there,
> 
> Hello. I have a problem with btrfs :\ I'm using btrfs-progs v6.0.2 on Manjaro-ARM 22.12 (based on ArchLinux), kernel
> 6.0.12-1-MANJARO-ARM on RockPi4B.
> 
> I have a btrfs setup on two Seagate rotational HDD, 2TB and 1TB - both encrypted with dm-crypt.
> 
> I'm using it for backup mostly. It works in that way, there is na subvolume /Backup/Host directory and when time of
> backup (daily) comes, script will create the subvolume snapshot /Backup/Host_date_daily and after that it will rsync
> remote data with that /Backup/Host directory.
> I have 2 such "Hosts" with around 80 snapshots per each. Quota is enabled to see the usage of snapshots. Everything was
> working without any problem for months.
> 
> The problem is that 2 days ago I decided that I have too many snapshots and I have "btrfs subvolume delete" about 30 of
> them. Since then both drives are running constantly doing something. "iotop" shows mostly btrfs-cleaner doing disk reads
> at around 200KB/s.
> I think btrfs-transaction is starting first and after that btrfs-cleaner is doing something.
> I can still read and write files to this btrfs. No errors related to btrfs in dmesg or system logs (surely there are
> hang_tasks).
> 
> But filesystem is running very, very slow and "sudo btrfs qgroup show /Backup/" shows this:

Since you're using qgroup and dropping a tons of subvolumes, you're 
hitting the remaining qgroup performance bottleneck.

When doing snapshot drop, especially for larger snapshots, qgroup will 
mark the whole subtree as dirty, and causing transaction to hang for a 
long time, depending on how many tree blocks are shared between the 
snapshots.

For now, you can disable qgroup for now, and re-enable after the large 
snapshot removal.

For v6.1 and newer kernel, this problem can at least be worked around 
using the new /sys/fs/btrfs/<uuid>/qgroups/drop_subtree_threshold 
interface to do the quota disable automatically based on the size of 
subtree we're going to drop.


Thanks,
Qu
> 
> $ sudo btrfs qgroup show /Backup/
> Qgroupid    Referenced    Exclusive   Path
> --------    ----------    ---------   ----
> 0/5          140.48MiB    140.48MiB   <toplevel>
> 0/1621        48.82GiB     48.82GiB   Backups
> 0/1622        83.93GiB    156.24MiB   Backups/Worker
> 0/1625       118.42GiB    118.42GiB   Series
> 0/2891        71.45GiB      2.99GiB   Backups/Worker_2022-01-01-21-48-00_yearly
> 0/2892         4.44GiB    639.24MiB   Backups/Rock
> 0/2893        66.74GiB        0.00B   <stale>
> 0/2894        58.57GiB     16.00EiB   <stale>
> 0/2916        85.91GiB     17.66GiB   Backups/Worker_2022-02-06-22-17-57_monthly
> 0/2923        67.12GiB        0.00B   <stale>
> 0/2925       551.57MiB        0.00B   <stale>
> 0/2928        68.08GiB     16.00EiB   <stale>
> 0/2933         3.63GiB    634.17MiB   Backups/Rock_2022-02-21-03-22-01_yearly
> 0/2937        62.62GiB     16.00EiB   <stale>
> 0/2941         3.64GiB    647.02MiB   Backups/Rock_2022-02-28-03-46-01_monthly
> 0/2943        75.31GiB      3.47GiB   Backups/Worker_2022-03-01-09-04-25_monthly
> 0/2950         3.99GiB      1.09GiB   Backups/Rock_2022-03-07-03-18-01_monthly
> 0/2955        66.44GiB        0.00B   <stale>
> 0/2959         2.58GiB        0.00B   <stale>
> 0/2960        59.93GiB     16.00EiB   <stale>
> 0/2973         1.90GiB     16.00EiB   <stale>
> 0/2974        71.93GiB     16.00EiB   <stale>
> 0/3020         1.96GiB        0.00B   <stale>
> 0/3021        69.18GiB     16.00EiB   <stale>
> 0/3097         4.08GiB    793.08MiB   Backups/Rock_2022-04-04-03-33-01_monthly
> 0/3098        77.99GiB      1.37GiB   Backups/Worker_2022-04-04-03-37-00_monthly
> 0/3113         2.47GiB        0.00B   <stale>
> 0/3114        72.76GiB        0.00B   <stale>
> 0/3123         2.73GiB      2.73GiB   youtube
> 0/3128         2.47GiB        0.00B   <stale>
> 0/3129        69.77GiB     16.00EiB   <stale>
> 0/3142         2.41GiB        0.00B   <stale>
> 0/3143        70.07GiB     16.00EiB   <stale>
> 0/3156         3.99GiB    631.05MiB   Backups/Rock_2022-05-02-03-11-01_monthly
> 0/3157        73.85GiB      1.08GiB   Backups/Worker_2022-05-02-03-14-36_monthly
> 0/3170         2.38GiB        0.00B   <stale>
> 0/3171        72.36GiB        0.00B   <stale>
> 0/3184         2.26GiB        0.00B   <stale>
> 0/3185        70.15GiB        0.00B   <stale>
> 0/3219         2.25GiB        0.00B   <stale>
> 0/3220        61.60GiB        0.00B   <stale>
> 0/3238         2.25GiB        0.00B   <stale>
> 0/3239        69.60GiB     16.00EiB   <stale>
> 0/3253         4.07GiB    757.08MiB   Backups/Rock_2022-06-06-03-06-01_monthly
> 0/3254        74.09GiB      2.22GiB   Backups/Worker_2022-06-06-03-10-20_monthly
> 0/3267         2.25GiB        0.00B   <stale>
> 0/3268        70.07GiB        0.00B   <stale>
> 0/3281         1.25GiB        0.00B   <stale>
> 0/3282        62.10GiB     16.00EiB   <stale>
> 0/3295         2.33GiB        0.00B   <stale>
> 0/3296        67.27GiB     16.00EiB   <stale>
> 0/3309         4.08GiB    759.00MiB   Backups/Rock_2022-07-04-03-47-01_monthly
> 0/3310        71.30GiB      1.19GiB   Backups/Worker_2022-07-04-03-50-40_monthly
> 0/3323         4.11GiB    781.59MiB   Backups/Rock_2022-07-11-03-33-02_weekly
> 0/3324        84.58GiB      2.25GiB   Backups/Worker_2022-07-11-03-36-52_weekly
> 0/3337         4.13GiB    542.32MiB   Backups/Rock_2022-07-18-03-31-02_weekly
> 0/3338        84.97GiB      1.64GiB   Backups/Worker_2022-07-18-03-35-11_weekly
> 0/3351         4.15GiB    565.59MiB   Backups/Rock_2022-07-25-03-29-01_weekly
> 0/3352        88.75GiB      5.36GiB   Backups/Worker_2022-07-25-03-33-10_weekly
> 0/3800         4.19GiB    590.85MiB   Backups/Rock_2022-08-24-14-03-29_monthly
> 0/3801        84.10GiB    270.35MiB   Backups/Worker_2022-08-24-14-09-41_monthly
> 0/3806           0.00B        0.00B   <stale>
> 0/3807           0.00B        0.00B   <stale>
> 0/3810         3.65GiB    437.50MiB   <stale>
> 0/3811           0.00B        0.00B   <stale>
> 0/3814         4.20GiB    441.68MiB   Backups/Rock_2022-08-31-03-28-01_weekly
> 0/3815        84.22GiB    205.55MiB   Backups/Worker_2022-08-31-03-34-46_weekly
> 0/3820         4.21GiB    577.40MiB   Backups/Rock_2022-09-03-03-08-01_monthly
> 0/3821        84.27GiB    531.27MiB   Backups/Worker_2022-09-03-03-14-46_monthly
> 0/3824         4.21GiB    324.41MiB   <stale>
> 0/3825           0.00B        0.00B   <stale>
> 0/3828         4.21GiB    321.98MiB   <stale>
> 0/3829           0.00B        0.00B   <stale>
> 0/3834         4.22GiB    330.94MiB   Backups/Rock_2022-09-10-03-29-02_weekly
> 0/3835        84.56GiB    378.85MiB   Backups/Worker_2022-09-10-03-36-08_weekly
> 0/3838         4.22GiB    334.16MiB   <stale>
> 0/3839           0.00B        0.00B   <stale>
> 0/3842         4.22GiB    346.15MiB   <stale>
> 0/3843           0.00B        0.00B   <stale>
> 0/3848         4.25GiB    347.53MiB   Backups/Rock_2022-09-17-03-33-01_weekly
> 0/3849        86.23GiB    846.90MiB   Backups/Worker_2022-09-17-03-39-44_weekly
> 0/3852         4.25GiB    605.70MiB   <stale>
> 0/3853           0.00B        0.00B   <stale>
> 0/3856         4.26GiB    597.55MiB   <stale>
> 0/3857           0.00B        0.00B   <stale>
> 0/3862         4.26GiB    346.20MiB   Backups/Rock_2022-09-24-03-23-01_weekly
> 0/3863        85.57GiB    695.52MiB   Backups/Worker_2022-09-24-03-29-36_weekly
> 0/3866         4.27GiB    348.67MiB   <stale>
> 0/3867           0.00B        0.00B   <stale>
> 0/3870         4.27GiB    350.59MiB   <stale>
> 0/3871           0.00B        0.00B   <stale>
> 0/3876         4.28GiB    610.16MiB   Backups/Rock_2022-10-01-03-41-01_monthly
> 0/3877        85.24GiB    392.69MiB   Backups/Worker_2022-10-01-03-48-39_monthly
> 0/3880         4.29GiB    611.82MiB   Backups/Rock_2022-10-03-03-18-01_daily
> 0/3881        85.25GiB    153.19MiB   Backups/Worker_2022-10-03-03-24-38_daily
> 0/3884         4.29GiB    613.87MiB   Backups/Rock_2022-10-05-03-32-01_daily
> 0/3885        85.28GiB    153.84MiB   Backups/Worker_2022-10-05-03-38-59_daily
> 0/3890         4.29GiB    364.01MiB   Backups/Rock_2022-10-08-03-24-01_weekly
> 0/3891        85.42GiB    211.12MiB   Backups/Worker_2022-10-08-03-31-13_weekly
> 0/3894         4.30GiB    370.67MiB   Backups/Rock_2022-10-10-03-45-01_daily
> 0/3895        80.24GiB    144.07MiB   Backups/Worker_2022-10-10-03-52-24_daily
> 0/3898         4.30GiB    382.05MiB   Backups/Rock_2022-10-12-03-47-01_daily
> 0/3899        80.24GiB    167.02MiB   Backups/Worker_2022-10-12-03-54-28_daily
> 0/3904         4.31GiB    637.77MiB   Backups/Rock_2022-10-15-03-32-01_daily
> 0/3905        80.28GiB    147.47MiB   Backups/Worker_2022-10-15-03-39-19_daily
> 0/3908         4.32GiB    383.93MiB   Backups/Rock_2022-10-17-03-12-01_weekly
> 0/3909        80.29GiB      4.00KiB   Backups/Worker_2022-10-17-03-19-03_weekly
> 0/3912         4.32GiB    387.17MiB   Backups/Rock_2022-10-19-03-14-01_daily
> 0/3913        80.29GiB      4.00KiB   Backups/Worker_2022-10-19-03-21-08_daily
> 0/3918         4.32GiB    391.86MiB   Backups/Rock_2022-10-22-03-19-02_daily
> 0/3919        80.29GiB      4.00KiB   Backups/Worker_2022-10-22-03-26-49_daily
> 0/3922         4.32GiB    389.36MiB   Backups/Rock_2022-10-24-03-09-01_daily
> 0/3923        80.29GiB      4.00KiB   Backups/Worker_2022-10-24-03-17-38_weekly
> 0/3926         4.29GiB    520.51MiB   Backups/Rock_2022-10-26-03-10-01_weekly
> 0/3927        80.76GiB    614.79MiB   Backups/Worker_2022-10-26-03-16-39_daily
> 0/3932         4.30GiB    402.08MiB   Backups/Rock_2022-10-29-03-17-02_daily
> 0/3933        82.46GiB    358.48MiB   Backups/Worker_2022-10-29-03-25-19_daily
> 0/3936         4.30GiB    401.73MiB   Backups/Rock_2022-10-31-03-44-01_daily
> 0/3937        82.46GiB    170.46MiB   Backups/Worker_2022-10-31-03-53-04_daily
> 0/3940         4.31GiB    534.66MiB   Backups/Rock_2022-11-02-03-48-01_monthly
> 0/3941        82.56GiB    157.15MiB   Backups/Worker_2022-11-02-03-57-02_monthly
> 0/3946         4.32GiB    540.91MiB   Backups/Rock_2022-11-05-03-29-01_daily
> 0/3947        91.42GiB      7.98GiB   Backups/Worker_2022-11-05-03-41-01_daily
> 0/3950         4.32GiB    414.85MiB   Backups/Rock_2022-11-07-03-27-01_daily
> 0/3951        83.61GiB     48.00KiB   Backups/Worker_2022-11-07-03-35-31_daily
> 0/3962         4.32GiB    416.47MiB   Backups/Rock_2022-11-09-03-27-01_weekly
> 0/3963        83.61GiB     48.00KiB   Backups/Worker_2022-11-09-03-34-50_weekly
> 0/3971         4.32GiB    419.59MiB   Backups/Rock_2022-11-12-03-51-01_daily
> 0/3972        83.61GiB     48.00KiB   Backups/Worker_2022-11-12-03-59-47_daily
> 0/3975         4.33GiB    424.70MiB   Backups/Rock_2022-11-14-03-34-01_daily
> 0/3976        83.61GiB     48.00KiB   Backups/Worker_2022-11-14-03-46-47_daily
> 0/3979         4.33GiB    439.48MiB   Backups/Rock_2022-11-16-03-46-01_weekly
> 0/3980        83.53GiB    549.00MiB   Backups/Worker_2022-11-16-03-54-50_daily
> 0/3985         4.33GiB    435.20MiB   Backups/Rock_2022-11-19-03-11-01_daily
> 0/3986        85.00GiB    344.77MiB   Backups/Worker_2022-11-19-03-18-47_weekly
> 0/3989         4.34GiB    438.37MiB   Backups/Rock_2022-11-21-03-45-02_daily
> 0/3990        84.37GiB    110.88MiB   Backups/Worker_2022-11-21-03-52-53_daily
> 0/3991         4.34GiB    441.27MiB   Backups/Rock_2022-11-22-03-40-01_daily
> 0/3992        84.37GiB    102.42MiB   Backups/Worker_2022-11-22-03-47-49_daily
> 0/3993         4.34GiB    443.73MiB   Backups/Rock_2022-11-23-03-12-01_weekly
> 0/3994        85.61GiB    130.42MiB   Backups/Worker_2022-11-23-03-20-05_daily
> 0/3995         4.35GiB    700.11MiB   Backups/Rock_2022-11-24-03-46-01_daily
> 0/3996        85.59GiB    120.38MiB   Backups/Worker_2022-11-24-03-54-27_daily
> 0/3997         4.35GiB    445.20MiB   Backups/Rock_2022-11-25-03-13-01_daily
> 0/3998        85.60GiB    123.75MiB   Backups/Worker_2022-11-25-03-21-28_daily
> 0/3999         4.35GiB    449.13MiB   Backups/Rock_2022-11-26-03-12-01_daily
> 0/4000        85.60GiB    126.18MiB   Backups/Worker_2022-11-26-03-20-04_daily
> 0/4001         4.35GiB    450.89MiB   Backups/Rock_2022-11-27-03-20-01_weekly
> 0/4002        85.62GiB    109.21MiB   Backups/Worker_2022-11-27-03-29-24_weekly
> 0/4003         4.35GiB    580.07MiB   Backups/Rock_2022-11-28-03-51-01_daily
> 0/4004        85.75GiB    103.49MiB   Backups/Worker_2022-11-28-04-00-41_daily
> 0/4005         4.36GiB    580.75MiB   Backups/Rock_2022-11-29-03-11-01_daily
> 0/4006        85.77GiB    103.75MiB   Backups/Worker_2022-11-29-03-20-30_daily
> 0/4007         4.36GiB    455.78MiB   Backups/Rock_2022-11-30-03-15-01_daily
> 0/4008        85.52GiB    126.70MiB   Backups/Worker_2022-11-30-03-23-44_daily
> 0/4009         4.36GiB    457.26MiB   Backups/Rock_2022-12-01-03-43-01_monthly
> 0/4010        85.54GiB    141.18MiB   Backups/Worker_2022-12-01-03-51-35_monthly
> 0/4011         4.36GiB    586.95MiB   Backups/Rock_2022-12-02-03-07-02_daily
> 0/4012        85.63GiB    148.86MiB   Backups/Worker_2022-12-02-03-15-39_daily
> 0/4013         4.36GiB    585.41MiB   Backups/Rock_2022-12-03-03-11-01_daily
> 0/4014        85.69GiB    131.99MiB   Backups/Worker_2022-12-03-03-21-14_daily
> 0/4015         4.36GiB    586.59MiB   Backups/Rock_2022-12-04-03-14-01_weekly
> 0/4016        85.67GiB     70.44MiB   Backups/Worker_2022-12-04-03-24-30_weekly
> 0/4017         4.36GiB    458.87MiB   Backups/Rock_2022-12-05-03-36-01_daily
> 0/4018        85.85GiB    102.37MiB   Backups/Worker_2022-12-05-03-44-57_daily
> 0/4019         4.37GiB    460.50MiB   Backups/Rock_2022-12-06-03-08-01_daily
> 0/4020        85.80GiB    100.37MiB   Backups/Worker_2022-12-06-03-15-31_daily
> 0/4021         4.37GiB    597.72MiB   Backups/Rock_2022-12-07-03-39-01_daily
> 0/4022        85.80GiB    128.71MiB   Backups/Worker_2022-12-07-03-46-40_daily
> 0/4023         4.37GiB    595.17MiB   Backups/Rock_2022-12-08-03-24-02_daily
> 0/4024        85.79GiB    152.18MiB   Backups/Worker_2022-12-08-03-32-13_daily
> 0/4025         4.37GiB    724.81MiB   Backups/Rock_2022-12-09-03-23-01_daily
> 0/4026        86.06GiB    150.18MiB   Backups/Worker_2022-12-09-03-30-50_daily
> 0/4027         4.39GiB    612.35MiB   Backups/Rock_2022-12-10-03-34-01_daily
> 0/4028        86.08GiB    133.16MiB   Backups/Worker_2022-12-10-03-42-09_daily
> 0/4029         4.39GiB    611.90MiB   Backups/Rock_2022-12-11-03-14-01_weekly
> 0/4030        97.40GiB     11.53GiB   Backups/Worker_2022-12-11-03-23-09_weekly
> 0/4031         4.39GiB    615.16MiB   Backups/Rock_2022-12-12-03-41-01_daily
> 0/4032        86.10GiB    360.52MiB   Backups/Worker_2022-12-12-03-49-13_daily
> 0/4033         4.39GiB    616.20MiB   Backups/Rock_2022-12-13-03-29-02_daily
> 0/4034        85.85GiB    128.28MiB   Backups/Worker_2022-12-13-03-37-17_daily
> 0/4035         4.39GiB    616.02MiB   Backups/Rock_2022-12-14-03-50-01_daily
> 0/4036        87.58GiB      1.77GiB   Backups/Worker_2022-12-14-04-00-04_daily
> 0/4037         4.40GiB    746.32MiB   Backups/Rock_2022-12-15-03-46-01_daily
> 0/4038        88.34GiB      1.74GiB   Backups/Worker_2022-12-15-04-09-42_daily
> 0/4039         4.43GiB    749.24MiB   Backups/Rock_2022-12-16-03-19-01_daily
> 0/4040        88.25GiB      1.74GiB   Backups/Worker_2022-12-16-03-28-45_daily
> 0/4041         4.44GiB    621.57MiB   Backups/Rock_2022-12-17-03-42-01_daily
> 0/4042        86.74GiB      1.74GiB   Backups/Worker_2022-12-17-03-55-19_daily
> 0/4043         4.44GiB    626.07MiB   Backups/Rock_2022-12-18-03-27-01_weekly
> 0/4044        86.75GiB      1.72GiB   Backups/Worker_2022-12-18-03-38-27_weekly
> 0/4045         4.44GiB    628.16MiB   Backups/Rock_2022-12-19-03-19-01_daily
> 0/4046        86.09GiB      1.86GiB   Backups/Worker_2022-12-19-03-30-50_daily
> 0/4047         4.43GiB    758.10MiB   Backups/Rock_2022-12-20-03-11-01_daily
> 0/4048        84.36GiB    115.30MiB   Backups/Worker_2022-12-20-03-21-08_daily
> 0/4049        62.29GiB      6.18MiB   Backups/Media
> 0/4050         4.43GiB    631.20MiB   Backups/Rock_2022-12-21-03-16-01_daily
> 0/4051        84.37GiB    142.07MiB   Backups/Worker_2022-12-21-03-24-05_daily
> 0/4052        62.29GiB      6.17MiB   Backups/Media_2022-12-22-00-10-11_daily
> 0/4053         4.43GiB    502.88MiB   Backups/Rock_2022-12-22-00-13-18_daily
> 0/4054        84.37GiB     97.67MiB   Backups/Worker_2022-12-22-01-38-55_daily
> 0/4055        62.29GiB      6.16MiB   Backups/Media_2022-12-23-08-02-28_daily
> 0/4056         4.43GiB    505.86MiB   Backups/Rock_2022-12-23-08-04-13_daily
> 0/4057        85.46GiB     85.36MiB   Backups/Worker_2022-12-23-08-12-41_daily
> 0/4058        62.29GiB      6.16MiB   Backups/Media_2022-12-24-07-31-47_daily
> 0/4059         4.44GiB    636.38MiB   Backups/Rock_2022-12-24-07-33-28_daily
> 0/4060        85.56GiB    128.61MiB   Backups/Worker_2022-12-24-07-42-13_daily
> 
> I wonder if something wrong seriously or do I need just be patient and it will be allright?
> But it is 2 days like that? Do you see that "16.00EiB" 😉
> Looks like a coruption to me :\
> 
> Maybe some fix can be done? Some diagnostics? Is it a time to evacuate the data (there are not only backups)?
> What do you think?
> 
> Infos:
> 
> # uname -a
> Linux rock 6.0.12-1-MANJARO-ARM #1 SMP PREEMPT Thu Dec 8 14:18:34 UTC 2022 aarch64 GNU/Linux
> 
> # btrfs --version
> btrfs-progs v6.0.2
> 
> # btrfs fi show
> Label: 'DATA01'  uuid: c750664b-4029-43df-9513-c234f18661c9
> 	Total devices 2 FS bytes used 837.74GiB
> 	devid    1 size 1.82TiB used 562.03GiB path /dev/mapper/cryptdata01
> 	devid    2 size 931.50GiB used 562.03GiB path /dev/mapper/cryptdata02
> 
> # btrfs fi df /btrfs
> System, RAID0: total=64.00MiB, used=92.00KiB
> Data+Metadata, RAID0: total=1.10TiB, used=837.74GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> dmesg.log attached. Notice that I have disabled hang tasks warnings after some time.
> But there are still happening.
> 
