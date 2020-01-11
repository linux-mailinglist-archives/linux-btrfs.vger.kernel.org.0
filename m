Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F8138290
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2020 18:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgAKREf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Jan 2020 12:04:35 -0500
Received: from ms11p00im-qufo17291901.me.com ([17.58.38.48]:34219 "EHLO
        ms11p00im-qufo17291901.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730420AbgAKREf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Jan 2020 12:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578762272;
        bh=FLHKzK7BGJsiLuAI0/I/K5wyP4i4VXKGV69VXGuqKwA=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=i+roQ24cJ8YnUmsEEpNTz5g72EfNpk7fhhwPK2Dqd+2gC49Z1PwoN1TBWTYx47471
         o3zA8v3l+1ezLrmxbpxY+wbrU0IGcqJaXL8d67HCjyZ5tSyAMm4jz43U3G3zp2i5ms
         vS8QiZuTUjFUifaqAsTNlNjbsyy00yQDMXo883hlHC2Fy+sDdADQImSZ28ubGRc9ct
         IrlcZFfyaw2qOTNc6ija2ualTQ/XlcLwEV2DwIg/WTllSjbCq1W7MC5MGcXETCVZko
         juuNnri57bhh+x1KyIcQalOZ0B8d8bKkxIE8DhvYjue1RoFk21VRWi1mXWAX1jbmIp
         MSCjBMZCpEnjw==
Received: from [192.168.15.23] (unknown [177.76.36.47])
        by ms11p00im-qufo17291901.me.com (Postfix) with ESMTPSA id B572E580B64;
        Sat, 11 Jan 2020 17:04:30 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: 12 TB btrfs file system on virtual machine broke again (third time)
From:   Christian Wimmer <telefonchris@icloud.com>
In-Reply-To: <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
Date:   Sat, 11 Jan 2020 14:04:27 -0300
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B871DCD7-7EA7-4AA2-ADB1-0F899F764972@icloud.com>
References: <20191206034406.40167-1-wqu@suse.com>
 <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com>
 <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com>
 <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com>
 <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com>
 <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com>
 <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com>
 <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
 <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
 <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001110149
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi guys,

and again my 12TB virtual machine btrfs file system broke into pieces.
I checked today in the morning and there was not any error message =
regarding btrfs.
10 minutes ago I needed to suspend the virtual machine and after I =
resumed, all folders on my (still mounted) file system have gone.
So in my opinion, the Parallels Virtual machine is not cleanly handling =
this.

Is there anything I can do now to save my data?
This are the error log messages:



# tail -f /var/log/messages
2020-01-11T13:57:55.739361-03:00 linux-ze6w kernel: [512260.892881] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:57:57.986773-03:00 linux-ze6w chronyd[1943]: Selected =
source 185.184.223.224
2020-01-11T13:58:00.766543-03:00 linux-ze6w kernel: [512265.894004] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:00.766559-03:00 linux-ze6w kernel: [512265.894089] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:02.891790-03:00 linux-ze6w sudo:    chris : TTY=3Dpts/100=
 ; PWD=3D/home/chris ; USER=3Droot ; COMMAND=3D/usr/bin/su
2020-01-11T13:58:02.893238-03:00 linux-ze6w sudo: =
pam_unix(sudo:session): session opened for user root by chris(uid=3D0)
2020-01-11T13:58:02.897765-03:00 linux-ze6w su: (to root) chris on =
pts/100
2020-01-11T13:58:02.898820-03:00 linux-ze6w su: pam_unix(su:session): =
session opened for user root by chris(uid=3D0)
2020-01-11T13:58:05.798179-03:00 linux-ze6w kernel: [512270.925046] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:05.798193-03:00 linux-ze6w kernel: [512270.925102] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:10.822192-03:00 linux-ze6w kernel: [512275.951137] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:10.822204-03:00 linux-ze6w kernel: [512275.951174] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:15.850385-03:00 linux-ze6w kernel: [512280.977909] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:15.850400-03:00 linux-ze6w kernel: [512280.977975] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:20.882236-03:00 linux-ze6w kernel: [512286.010503] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:20.882247-03:00 linux-ze6w kernel: [512286.010577] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:22.234199-03:00 linux-ze6w kernel: [512287.361025] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110521344
2020-01-11T13:58:22.234213-03:00 linux-ze6w kernel: [512287.364054] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110472192
2020-01-11T13:58:22.234214-03:00 linux-ze6w kernel: [512287.364060] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110455808
2020-01-11T13:58:22.250399-03:00 linux-ze6w kernel: [512287.377085] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110488576
2020-01-11T13:58:22.270208-03:00 linux-ze6w kernel: [512287.397958] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110455808
2020-01-11T13:58:22.270221-03:00 linux-ze6w kernel: [512287.398038] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110455808
2020-01-11T13:58:22.270221-03:00 linux-ze6w kernel: [512287.398067] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562110455808
2020-01-11T13:58:23.098451-03:00 linux-ze6w kernel: [512288.225913] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562059993088
2020-01-11T13:58:25.910246-03:00 linux-ze6w kernel: [512291.036604] =
btree_readpage_end_io_hook: 17 callbacks suppressed
2020-01-11T13:58:25.910266-03:00 linux-ze6w kernel: [512291.036607] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:25.910267-03:00 linux-ze6w kernel: [512291.036708] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:26.338226-03:00 linux-ze6w kernel: [512291.467459] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:26.338237-03:00 linux-ze6w kernel: [512291.467517] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:26.338238-03:00 linux-ze6w kernel: [512291.467585] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:26.338238-03:00 linux-ze6w kernel: [512291.467624] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:28.882182-03:00 linux-ze6w kernel: [512294.011515] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:28.914197-03:00 linux-ze6w kernel: [512294.041798] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:28.914214-03:00 linux-ze6w kernel: [512294.041883] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:28.914214-03:00 linux-ze6w kernel: [512294.041936] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:30.938342-03:00 linux-ze6w kernel: [512296.064421] =
btree_readpage_end_io_hook: 4 callbacks suppressed
2020-01-11T13:58:30.938354-03:00 linux-ze6w kernel: [512296.064425] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:30.938355-03:00 linux-ze6w kernel: [512296.064503] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:32.078216-03:00 linux-ze6w kernel: [512297.204873] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562285453312
2020-01-11T13:58:32.078230-03:00 linux-ze6w kernel: [512297.205110] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562285453312
2020-01-11T13:58:32.078230-03:00 linux-ze6w kernel: [512297.205174] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562285453312
2020-01-11T13:58:32.078232-03:00 linux-ze6w kernel: [512297.205212] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562285453312
2020-01-11T13:58:35.962296-03:00 linux-ze6w kernel: [512301.090582] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:35.962308-03:00 linux-ze6w kernel: [512301.090653] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:40.482196-03:00 linux-ze6w kernel: [512305.611514] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:40.482211-03:00 linux-ze6w kernel: [512305.611572] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:40.482212-03:00 linux-ze6w kernel: [512305.611624] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:40.482213-03:00 linux-ze6w kernel: [512305.611664] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562258780160
2020-01-11T13:58:40.990210-03:00 linux-ze6w kernel: [512306.116117] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:40.990226-03:00 linux-ze6w kernel: [512306.116218] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:42.530181-03:00 linux-ze6w kernel: [512307.659684] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:42.530194-03:00 linux-ze6w kernel: [512307.659724] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:42.530194-03:00 linux-ze6w kernel: [512307.659762] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:42.530195-03:00 linux-ze6w kernel: [512307.659800] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345484288
2020-01-11T13:58:43.462391-03:00 linux-ze6w kernel: [512308.589145] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:43.462410-03:00 linux-ze6w kernel: [512308.590058] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:43.462410-03:00 linux-ze6w kernel: [512308.590113] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:43.462412-03:00 linux-ze6w kernel: [512308.590152] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:46.014183-03:00 linux-ze6w kernel: [512311.142992] =
btree_readpage_end_io_hook: 20 callbacks suppressed
2020-01-11T13:58:46.014200-03:00 linux-ze6w kernel: [512311.142994] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:46.014200-03:00 linux-ze6w kernel: [512311.143077] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:46.290228-03:00 linux-ze6w kernel: [512311.418594] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:46.290246-03:00 linux-ze6w kernel: [512311.418638] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:51.042208-03:00 linux-ze6w kernel: [512316.170407] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:51.042229-03:00 linux-ze6w kernel: [512316.170495] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:53.786220-03:00 linux-ze6w kernel: [512318.911878] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562059993088
2020-01-11T13:58:53.786240-03:00 linux-ze6w kernel: [512318.911963] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562059993088
2020-01-11T13:58:53.786241-03:00 linux-ze6w kernel: [512318.913482] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:53.786241-03:00 linux-ze6w kernel: [512318.913583] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562345451520
2020-01-11T13:58:53.786242-03:00 linux-ze6w kernel: [512318.913588] =
BTRFS: error (device sdc1) in __btrfs_run_delayed_items:1148: errno=3D-5 =
IO failure
2020-01-11T13:58:53.786242-03:00 linux-ze6w kernel: [512318.913590] =
BTRFS info (device sdc1): forced readonly
2020-01-11T13:58:53.786242-03:00 linux-ze6w kernel: [512318.913591] =
BTRFS warning (device sdc1): Skipping commit of aborted transaction.
2020-01-11T13:58:53.786243-03:00 linux-ze6w kernel: [512318.913592] =
BTRFS: error (device sdc1) in cleanup_transaction:1881: errno=3D-5 IO =
failure
2020-01-11T13:58:56.078317-03:00 linux-ze6w kernel: [512321.203683] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472
2020-01-11T13:58:56.078334-03:00 linux-ze6w kernel: [512321.203751] =
BTRFS error (device sdc1): bad tree block start 14275350892879035392 =
2562508521472

Thanks,

Chris

