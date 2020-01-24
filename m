Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0637114855A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 13:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388682AbgAXMpt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 07:45:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52676 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387574AbgAXMpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 07:45:49 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00OCj1UO018932;
        Fri, 24 Jan 2020 04:45:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zH8eBYIyNynmD8wvnuYtObhGB+r0tNeBMYKGFXTBLsA=;
 b=JKQJureXMK5OIB37lJV3zjYFt1nHjxb7WXJOYy2M+0R6cel3qsGx8VioYycYcoD7EfOK
 5CV2dxF68FqcOrT6A1Nk3KUQ+TkdiYEpdmWoHyi53gN9Qez5XvpWoyBW948PyDNjYzAh
 G6pUCGtPvTKO22h00HVsWkcznGLgizmZd9o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xpxang3g6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Jan 2020 04:45:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 24 Jan 2020 04:45:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPLjnqbYujWp6UsE1gHkd0Q9wR3/8jBN60/7Qbgg1zkxcuzPS+D5f1oQ9F3jj+t8Y9QVwK+j4djVc+BnSffe4C2cWlCnPdGiWiKliwAFBZV57P0YGYnX5h417c2HLzIM07FaPiuH8/0DzqVwFNtosjBxkAt5XE40YAWI4OsgrXW9Dc/CFOz/o4ZDiu0AmoLvKOwRtE8rGDNjUndvtStRiO9cTOvkD3K/bCgbqPIANiu6v3ryK4wKfpVQv/fGukiXV1l2y0JL3m1DzXPJBfmn+CQ2YlHQxkrfV8+EDe/dkc1a+9Pyb9W4Paa96/VpgRG6X92ayir6unGTFWvxCxosFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH8eBYIyNynmD8wvnuYtObhGB+r0tNeBMYKGFXTBLsA=;
 b=Zi4hohBx/rKBNBUP9A1kYwKwSwjZhZp2aHtG/atba0GMyJWQuIOtiO9lKfudTZbf5B5+0M0q1zT3OIJBYJXnwPpkYyxXUyrisyr5772rjPc17fAU0QHu8n/DElMTo4QfoI4fDetYSC6/7wgUX0BpgBoSlXz9edhg4Wp8S0LKLMuqL2FXhQuCK0uIpfFcF1N59YogZg6DFG7LgcxvoV0uhWhXapdl1tx38/V5HPM7CR+EsEvtIg+zmcYQwMySgdtf5N7IlsnnBpy9UoteJQy9MyiJuzfIqx0V9lGo/L/TcnvE2O/CAe3jGL3saLYoUYR0yrEcAMZuMmweQXhWhIEFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH8eBYIyNynmD8wvnuYtObhGB+r0tNeBMYKGFXTBLsA=;
 b=Mh2LvgX7XYdEwLzg86jPe60es1CSUzTLFrYAjO9+Ra4gjNfoj76u2uLLBvD/wSP1UBh2pmvW+2pP7Kv4ssyJEOPuNvhQgwiEUmy1c5fhWmFBp+OHUP++a7jLJ+WfFMHk9Rmjvkg5nqHCKPgEL/BJWFR/qkFQgqa9c0JpZXo+ick=
Received: from SN6PR15MB2446.namprd15.prod.outlook.com (52.135.64.153) by
 SN6PR15MB2239.namprd15.prod.outlook.com (52.132.127.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 24 Jan 2020 12:45:41 +0000
Received: from SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10]) by SN6PR15MB2446.namprd15.prod.outlook.com
 ([fe80::615e:4236:ddfa:3d10%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 12:45:41 +0000
Received: from [172.30.22.196] (2620:10d:c091:480::4470) by MN2PR19CA0051.namprd19.prod.outlook.com (2603:10b6:208:19b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend Transport; Fri, 24 Jan 2020 12:45:40 +0000
From:   Chris Mason <clm@fb.com>
To:     Filipe Manana <fdmanana@gmail.com>
CC:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: flush write bio if we loop in
 extent_write_cache_pages
Thread-Topic: [PATCH] btrfs: flush write bio if we loop in
 extent_write_cache_pages
Thread-Index: AQHV0ixTTuuFWFHMhUesJowf6uvDdKf5jOwAgAA3FgA=
Date:   Fri, 24 Jan 2020 12:45:41 +0000
Message-ID: <4435E612-BB9E-4CE4-BA7D-13282489A7F7@fb.com>
References: <20200123203302.2180124-1-josef@toxicpanda.com>
 <CAL3q7H53O3Q_0DivEgwZBSRCjdfhNTxGemi4grWzJPzWHueYLg@mail.gmail.com>
In-Reply-To: <CAL3q7H53O3Q_0DivEgwZBSRCjdfhNTxGemi4grWzJPzWHueYLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.10r5443)
x-clientproxiedby: MN2PR19CA0051.namprd19.prod.outlook.com
 (2603:10b6:208:19b::28) To SN6PR15MB2446.namprd15.prod.outlook.com
 (2603:10b6:805:22::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:480::4470]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0380fd38-e85e-4789-100c-08d7a0cb5235
x-ms-traffictypediagnostic: SN6PR15MB2239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR15MB22396B0CDF09B05F18A9F8ABD30E0@SN6PR15MB2239.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(366004)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(33656002)(8936002)(52116002)(53546011)(2906002)(16526019)(186003)(81156014)(81166006)(71200400001)(966005)(478600001)(316002)(66476007)(8676002)(64756008)(66556008)(66946007)(5660300002)(66446008)(36756003)(6486002)(4326008)(6916009)(2616005)(54906003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2239;H:SN6PR15MB2446.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a96s9iZ69Wd5GbvQa3ItutWTuzKkAvfN+P/k7EJojanxRPHwcLiMeggPHKxDRGvKEZZ46FF2V+25gl+uQ9O5JHaj1cwNtrCJmIhDU+yqmNcBLSRNCWrM1h+b7YEqYEbSZt87jeD1lVkyG9NhDVI24YvVYZw2YFgYy2lFeEdvFNTGOboWZqtLHh7uZE3CJ3+8KDKVzOac6jsZbBVVy5hCj7u3cFxebigRp5X0Z3wh6wIraa+iw6FIE6+ayomDAqJHU8DT+C58v10lZOopGkcyoh8RC7hG7hxfbWhMQVx0u3o4W75vghBH4+9EZZB/qZFje1h0U0QGMOhWxTSqUdLr3AdZnAwnD+Vl24029wtWFWWjWSzS9/4YqVSUWOBARikUdq9M789lFZw8BieeTQm5X5/sSZTCe2xPNwTkjQQ11thtb8pD5xNI9oZdZa2mmAkbZPWyhmPZd8LtLod2+Yrv7J9LgHG2VkVpRuMahAB8zbmwFNN77slNryyg7BcSPIhuxyTyShrmy7md/8dKWlPu42c4aANRCrf9rC7UYhWmr2jlVnct+UX8zDMNFCNGufMOC/89jAoVMWBLSBbnKXFkDg==
x-ms-exchange-antispam-messagedata: wpHREpNx82lrsOumfGqhx1FGK3qzhifb1G82qweUnnEDlwjhCDS7P8YGENg8VDy+uQ0M41Vlu9VMUSTLgkTRHBMwBFMLG0Q9MMiqm9U34H/pI/POhjDdHBrD81Cwjt6Xfb7Pi4E1ur4jX7x3qcFDhavORYTGA7n5YfPtfgtQ/v0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0380fd38-e85e-4789-100c-08d7a0cb5235
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 12:45:41.5948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0t5LG8pkQqZ0N92vw/iyhJi/QjcLWdARKMuc+IbBzMrakUI75CNZskYZzVtFeRN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2239
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_03:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001240105
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24 Jan 2020, at 4:28, Filipe Manana wrote:

> On Thu, Jan 23, 2020 at 8:51 PM Josef Bacik <josef@toxicpanda.com>=20
> wrote:
>>
>> There exists a deadlock with range_cyclic that has existed forever. =20
>> If
>> we loop around with a bio already built we could deadlock with a=20
>> writer
>> who has the page locked that we're attempting to write but is waiting=20
>> on
>> a page in our bio to be written out.  The task traces are as follows
>>
>> PID: 1329874  TASK: ffff889ebcdf3800  CPU: 33  COMMAND:=20
>> "kworker/u113:5"
>>  #0 [ffffc900297bb658] __schedule at ffffffff81a4c33f
>>  #1 [ffffc900297bb6e0] schedule at ffffffff81a4c6e3
>>  #2 [ffffc900297bb6f8] io_schedule at ffffffff81a4ca42
>>  #3 [ffffc900297bb708] __lock_page at ffffffff811f145b
>>  #4 [ffffc900297bb798] __process_pages_contig at ffffffff814bc502
>>  #5 [ffffc900297bb8c8] lock_delalloc_pages at ffffffff814bc684
>>  #6 [ffffc900297bb900] find_lock_delalloc_range at ffffffff814be9ff
>>  #7 [ffffc900297bb9a0] writepage_delalloc at ffffffff814bebd0
>>  #8 [ffffc900297bba18] __extent_writepage at ffffffff814bfbf2
>>  #9 [ffffc900297bba98] extent_write_cache_pages at ffffffff814bffbd
>>
>> PID: 2167901  TASK: ffff889dc6a59c00  CPU: 14  COMMAND:
>> "aio-dio-invalid"
>>  #0 [ffffc9003b50bb18] __schedule at ffffffff81a4c33f
>>  #1 [ffffc9003b50bba0] schedule at ffffffff81a4c6e3
>>  #2 [ffffc9003b50bbb8] io_schedule at ffffffff81a4ca42
>>  #3 [ffffc9003b50bbc8] wait_on_page_bit at ffffffff811f24d6
>>  #4 [ffffc9003b50bc60] prepare_pages at ffffffff814b05a7
>>  #5 [ffffc9003b50bcd8] btrfs_buffered_write at ffffffff814b1359
>>  #6 [ffffc9003b50bdb0] btrfs_file_write_iter at ffffffff814b5933
>>  #7 [ffffc9003b50be38] new_sync_write at ffffffff8128f6a8
>>  #8 [ffffc9003b50bec8] vfs_write at ffffffff81292b9d
>>  #9 [ffffc9003b50bf00] ksys_pwrite64 at ffffffff81293032
>>
>> I used drgn to find the respective pages we were stuck on
>>
>> page_entry.page 0xffffea00fbfc7500 index 8148 bit 15 pid 2167901
>> page_entry.page 0xffffea00f9bb7400 index 7680 bit 0 pid 1329874
>>
>> As you can see the kworker is waiting for bit 0 (PG_locked) on index
>> 7680, and aio-dio-invalid is waiting for bit 15 (PG_writeback) on=20
>> index
>> 8148.  aio-dio-invalid has 7680, and the kworker epd looks like the
>> following
>
> Probably worth mentioning as well that it waits for writeback of the
> page to complete while holding a lock on it (at prepare_pages()).
> Anyway, it's a very minor thing and easy to figure that out.

Yeah, I was wondering if we should drop the lock in prepare_pages() and=20
make a goto again, but I don't think more complexity there is a good=20
idea.

>
>>
>> crash> struct extent_page_data ffffc900297bbbb0
>> struct extent_page_data {
>>   bio =3D 0xffff889f747ed830,
>>   tree =3D 0xffff889eed6ba448,
>>   extent_locked =3D 0,
>>   sync_io =3D 0
>> }
>>
>> and using drgn I walked the bio pages looking for page
>> 0xffffea00fbfc7500 which is the one we're waiting for writeback on
>>
>> bio =3D Object(prog, 'struct bio', address=3D0xffff889f747ed830)
>> for i in range(0, bio.bi_vcnt.value_()):
>>     bv =3D bio.bi_io_vec[i]
>>     if bv.bv_page.value_() =3D=3D 0xffffea00fbfc7500:
>>         print("FOUND IT")
>>
>> which validated what I suspected.
>>
>> The fix for this is simple, flush the epd before we loop back around=20
>> to
>> the beginning of the file during writeout.
>>
>> Fixes: b293f02e1423 ("Btrfs: Add writepages support")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> That dgrn, where is it? A quick google search pointed me only to
> blockchain stuff on the first page of results.

Holger had the right link for the docs, but=20
https://github.com/osandov/drgn works too.

Josef intermixes crash and drgn, but drgn supports most of the things=20
crash can do these days.

For this command:

crash> struct extent_page_data ffffc900297bbbb0

You can just ask drgn for the register you care about instead of having=20
to find it on the stack (see class drgn.StackFrame in the docs).

Tejun and Roman both shipped drgn scripts to help monitor bits of the=20
kernel:

https://lkml.org/lkml/2019/7/10/793
https://lore.kernel.org/linux-mm/20191016001504.1099106-1-guro@fb.com/t/

-chris
