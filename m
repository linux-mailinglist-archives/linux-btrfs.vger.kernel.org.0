Return-Path: <linux-btrfs+bounces-8563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88409990751
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 17:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9422E1F229D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A98E1C3028;
	Fri,  4 Oct 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="fxW2ml62"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48B61AA7AB
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055398; cv=fail; b=WHDz0p1ILPNMtI0Cs9FadXXp0drrBlCay1GYWl1Ydvsy5uJCkHIOrpRvqWRkRZ3ViGCU7v+ykQImLenzIMvlIjwqaR88o6j9XUxlNDxiBjvPVQqIUsYIjOkFbIknIWprKdVsSA3mSrK6ZC4L950uvNltmgOJ80GfR1HQ9avAs7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055398; c=relaxed/simple;
	bh=G5yuPByHeLPLd39tQvSAbwcUG/MHAveprg4RSmLh5nM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=OST63JAFis11rcWi1IEhsF38yvpgB/Q0cejx+BNnkRylyswNVLAVZZlNw2W+8ZPl38uIcymFqTipG4hJi+Yswa02i4QCznRLYABXtq/d5vuqDk7Ln9K0QcIX9Lhlwbivu4m4AydA6p1PzQq1P7Gr7eYQfWSkkZOjPgWXpr/jRMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=fxW2ml62; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494FJXrE028425
	for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2024 08:23:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=mdcD16sgXlin1kXQ7tDli+jD9VaLFsD3XpnBMSerpxw
	=; b=fxW2ml62OZAc4dyQY5ux4ZS+FusaQAa0mXV+NdIFBhYeYIau5f5uc05z1Vz
	RjvBs5s66Wh7bbbZR0/dWI6jsd23B0lQhxyzMlQWXTqsxtNFx+UjyMOTmOatOHYo
	vl8SyUkkFXYGM2r34jcGM5UPs8tugYWrbWJFL09rh+Wwcj3a1ivpRIdVw9uqy+uV
	wU/KF7bfWNPA0k1/+akFPQS5WXfrrM3MhAAif8YWPZ5/k1bh2uHxhRKRL+hIe90r
	0+0EuLmm3GhXmcQqQYmoUwoStaR4d4wO8KmUyiNvhJ0AcTMr7GeL+yVTrJmcRSEE
	xfT/pdtgELuLGfD6QfjDR3UNvPw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42204dx6wj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 08:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZHhaiOQ2cemwoRnPmclTA/8m7pKTURJ9OGzpGiEERDRtJQWrhYOdPXm619VF2E/tJAC+xFiTkS4qzWFUmsunFpT0fymxMvVHpVcz0Pq7itg6ls8+325cUkuaTXp5mkc+Qn0O++SnOaXr4GlL9XVNriAajzbKB8SeGG8ML1T9rAjrUeVY1N8EHPTA1ao+o8l4kGvPoVuu6Eip1KfPhylSeDRXB4nfHC3bAfFYYLCbeFD/vnj+x5TZBHUhnMKRT8cPjN1arK0Eg9NzI3+/aWFLCsKZdyAHq/h+gVf3PDghKRa5IA66wSNU6VJoUqD1pg9FNshommUwSgiP9RUcmM7OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpJathwQfjUk3bgsUPyoYt1yNT+HGMhjipDGjUz7FeA=;
 b=QSBoFea/sCxPdMM01Pmah23zo9ntgFGEF7NMOPobYcTx1hay+0l2DFghByZMkwhTnlKh0golk3FRwAEV9ez+r2jiEcv3LNkxT9gP45rruwbNHBBdP/ZMXxKe9ASqI8ot2+wGkk7ngAiQlbFafyB/fVekYoa18Fw+jwxTqlgoZ8JIc2UT3RvvTGC9jOYO1jCNRJ63GdcmsvdWDkHNthG3UmgLyMJXUu0+KKRsEPt71DcZWCRDXepUm+RFfrWIGuW9BzKDukafZt7bPQpvokbTpyOJMN7utTaRzb0ntgu5fvE4GA+QdgvMBjY4dAifLYzoNi6qSxQ8e0SXTwl1gG4imA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH0PR15MB5288.namprd15.prod.outlook.com (2603:10b6:510:145::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:23:10 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8005.024; Fri, 4 Oct 2024
 15:23:10 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs-progs: add rudimentary log checking
Thread-Topic: [PATCH v3] btrfs-progs: add rudimentary log checking
Thread-Index: AQHa1sSspxvgCt+1sES4tNhLmAmP2rJ0C9cAgAAViYCAAxO5gA==
Date: Fri, 4 Oct 2024 15:23:10 +0000
Message-ID: <4e76b91f-4565-4950-a633-91dccef87510@meta.com>
References: <20240715143830.2067478-1-maharmstone@fb.com>
 <CAL3q7H6xfZMa7htN3ebD7RZBYh2uJmcH4JvYcmjXRd6RaKTyug@mail.gmail.com>
 <4c742586-3eaf-4301-8a3e-333c3e032f6c@meta.com>
In-Reply-To: <4c742586-3eaf-4301-8a3e-333c3e032f6c@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH0PR15MB5288:EE_
x-ms-office365-filtering-correlation-id: 7b7bf3f8-3742-4a7b-c8eb-08dce48874b3
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mit5eDkvV2JwUm5nNXd2dXgrWmRBUjh3TGxnMjAzQkdRZUpvQkZ1QWlsa0Mx?=
 =?utf-8?B?cDhTSk9seHBuTERnQTVnWkFXaGlDNUh0S1Jxck5rNXpVZUN0ckxGcXdJMUNw?=
 =?utf-8?B?cmRVNGxaMUhTb0NIanpGS0dYZXUzU0JmaXRzYTkrODRXMkZ6eGVvejVtNElL?=
 =?utf-8?B?aFM3L0RSK3ZSSkFhUlQ5ZUk0andQVTUrRFJMNkp3YWxhZEZFdmxrQVUyQlMy?=
 =?utf-8?B?dlUyQ1oyTDNkZnMzS0VDODhac20zSG1zb214UTFrZ2NSYVdLWGk3Q0hjOGw3?=
 =?utf-8?B?UVNieFBJazF1VHdUT2FoNmNyUXA1OHRDeU1XcUgrVDN5bWJXRy9oWGcyQjdv?=
 =?utf-8?B?dHowK0ViNUd4Y01Oay9JdU9RV1FYenhaeUJBbG1va0l6OGd1bE45WEJGRUlz?=
 =?utf-8?B?cStYaEpCVlZKVEVyQlRoL0VTZFRYTlNOZDhITmp5R1pJRUxIUm54VDFaUDRh?=
 =?utf-8?B?OHV1ZHJ1QzAvZkFaK08rRDVmbGtRSC9xSXA5OEJRQllnT1Q1Z1FheTdyREhW?=
 =?utf-8?B?SXVwelZaMlVhK3dZVWpucXk5Z05oUWc5aVZ1T3Z3b0dtYkczL0tiMDFsaGF3?=
 =?utf-8?B?TGZ1RGdzRk53ZkVwZGhwRlFKWFJhMW1BaXFaVmRXN0xna1JqRk9uait3aE9W?=
 =?utf-8?B?WWpXMks3Q1BmazFmQ2F6eGhDeVlkT0NXemNFL3hBMmVrb3dMSnpyaUNDRU5v?=
 =?utf-8?B?K1Y3a0dHS3FDdlpRMVF3Y3dlM1dOQ2FlSEZ0VElNM29YdG9rdVVFdEFDQzF0?=
 =?utf-8?B?OWRlU3JzS0x6ZnF0clZ6eTY2WlRKWm1HQjdsVzZjNnI1elRWNlIzenlrbkQr?=
 =?utf-8?B?ZHRiZHZVckFyUS8wMW9Kb1pZWDl0ZzJ3ekNyaldBREp4TG5mWFJ1NitNczNX?=
 =?utf-8?B?UG1VYUo1REM0MW1IY3M4T1kyYXBPWUU2S3NxMEFMaVZ1M2w3SUMzTnB6cDR3?=
 =?utf-8?B?c3ZWRzlmYjhzUVA3ZmQ3ZlhWR0Ivc2pGT0NnU1B1ZWJQOGV0RnRXYTV4a05n?=
 =?utf-8?B?Y1U2QlZRQ3RFRnZCVXdTYWtMUUl6K2VqQnR6bk1iN2NFRGxENGIrb282bjdY?=
 =?utf-8?B?eUI0MjJPc0tsYkc3ZjB6Zmh3TWtPVVNiYzltVUhKTmNlSHlsSFhHRjJlZy9X?=
 =?utf-8?B?U2dqWVYvallFSmQvT2NsczRtTDlJZmZ4NHRZZ2FwbG50dmpyc2pHUURrNWhr?=
 =?utf-8?B?RTVxbkw5b295L0NCYnduZ1NRM3VxK0Y1SVBRK00yZFZvZjB4TkY1YTRQdHRB?=
 =?utf-8?B?WkRXMDl2dFhqU0RBN2R3ZTJHamU2UlhIYzBDZnNhSlYwRFVURFZJTFFxMWt4?=
 =?utf-8?B?RDVJZEFhUldmUElZRWNYOHVERzBUY0ZjVmRxMFBNcDM2UGNTeFNWd1VYREhD?=
 =?utf-8?B?bGdzWEVWYlNlNm5Kd09qQmkvY3ZiaXpCOUN0N0VISWt2OUlWN0p0M0JzZnB0?=
 =?utf-8?B?ZU5NRVdMRlBqb2VqSEx4VG5lVE0xdVhDLzRiYzN2Q3pvb0xyL0JuR0NqWFVD?=
 =?utf-8?B?Smt3ZVhVUFF1SHBCOGZzRk5UNm1OWmtXUGd4VEFsd1dEVFRzWFdwNWNseVpC?=
 =?utf-8?B?WDk5TVFZdGhZSnBGNXAwSnNKb3FNS2xOby9qVkU3VERHd2tWbWNzQnNiN01Q?=
 =?utf-8?B?ZmZsWmNscDlld1BXNUFHdDZsTmJwMnFGTDAvYksrdG5QbXI2M1RLNlJrYzdF?=
 =?utf-8?B?NFdvb0NCZTF3OGtIWWczc1Z0dVlJOVNFVG9iRThPSkp3Z2tYR1JzZ1Uvdm01?=
 =?utf-8?B?ZEY1U0wrOVJObnowVmlDckJ3bGh0Y24yTmIya3BSN1VuTGp5S1Z1UjNQZlZo?=
 =?utf-8?B?UDNjaWV5U1h0c25DMDZFdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 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
 =?utf-8?Q?bsvg=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7bf3f8-3742-4a7b-c8eb-08dce48874b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 15:23:10.4044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUaMSpr3Lk1xSYZoB9214rc+sTvhJF2tacE/HBOYC2LaUlRxmdpBvRsK+aV1WByLKJnxRru3idj6UBieTZjnJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5288
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <89BC01962FD9A8418935F2A56CBD92AF@namprd15.prod.outlook.com>
X-Proofpoint-GUID: ug7wvSaj-UL0Y5tJRC_by8xI1Tjjrll3
X-Proofpoint-ORIG-GUID: ug7wvSaj-UL0Y5tJRC_by8xI1Tjjrll3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_12,2024-10-04_01,2024-09-30_01

This PR fixes the issues in btrfs/056:=20
https://github.com/kdave/btrfs-progs/pull/904

Mark

On 2/10/24 17:23, Mark Harmstone wrote:
> Thanks Filipe, I'll look into it.
>=20
> Mark
>=20
> On 2/10/24 16:06, Filipe Manana wrote:
>> >>
>> On Mon, Jul 15, 2024 at 3:38=E2=80=AFPM Mark Harmstone <maharmstone@fb.c=
om>=20
>> wrote:
>>>
>>> Currently the transaction log is more or less ignored by btrfs check,
>>> meaning that it's possible for a FS with a corrupt log to pass btrfs
>>> check, but be immediately corrupted by the kernel when it's mounted.
>>>
>>> This patch adds a check that if there's an inode in the log, any pending
>>> non-compressed writes also have corresponding csum entries.
>>>
>>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>>> ---
>>> Changes:
>>> v2:
>>> helper to load log root
>>> handle compressed extents
>>> loop logic improvements
>>> fix bug in check_log_csum
>>>
>>> v3:
>>> added test
>>> added explanatory comment to check_log_csum
>>> changed length operation to -=3D
>>>
>>> =C2=A0 check/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
304 +++++++++++++++++-
>>> =C2=A0 .../063-log-missing-csum/default.img.xz=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | Bin 0 -> 1288 bytes
>>> =C2=A0 tests/fsck-tests/063-log-missing-csum/test.sh |=C2=A0 14 +
>>> =C2=A0 3 files changed, 306 insertions(+), 12 deletions(-)
>>> =C2=A0 create mode 100644=20
>>> tests/fsck-tests/063-log-missing-csum/default.img.xz
>>> =C2=A0 create mode 100755 tests/fsck-tests/063-log-missing-csum/test.sh
>>>
>>> diff --git a/check/main.c b/check/main.c
>>> index 83c721d3..eaae3042 100644
>>> --- a/check/main.c
>>> +++ b/check/main.c
>>> @@ -9787,6 +9787,274 @@ static int zero_log_tree(struct btrfs_root=20
>>> *root)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>>
>>> +/* Searches the given root for checksums in the range [addr,=20
>>> addr+length].
>>> + * Returns 1 if found, 0 if not found, and < 0 for an error. */
>>> +static int check_log_csum(struct btrfs_root *root, u64 addr, u64=20
>>> length)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 csum_size =3D gfs_info->csum_=
size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 num_entries;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 data_len;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_EXTENT_CSU=
M_OBJECTID;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_EXTENT_CSUM_KE=
Y;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D addr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, r=
oot, &key, &path, 0, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return ret;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0 && path.slots[0])
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 path.slots[0]--;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 leaf =3D path.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btr=
fs_next_leaf(root, &path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret > 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ret =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D pa=
th.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.objectid !=3D BTRFS_EXTENT_CSUM_OBJECTID ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type !=3D BTRFS_EXTENT_CSUM_KEY)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto next;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.offset >=3D addr + length)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 num_entries =3D btrfs_item_size(leaf, path.slots[0]) /=20
>>> csum_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 data_len =3D num_entries * gfs_info->sectorsize;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (addr >=3D key.offset && addr <=3D key.offset +=20
>>> data_len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 end =3D=
 min(addr + length, key.offset +=20
>>> data_len);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length -=3D=
 (end - addr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D en=
d;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (length =
=3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +
>>> +next:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 path.slots[0]++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret >=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D length =3D=3D 0 ? 1 : 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +}
>>> +
>>> +static int check_log_root(struct btrfs_root *root, struct cache_tree=20
>>> *root_cache,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 struct walk_control *wc)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret, err =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 last_csum_inode =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_FIRST_FREE=
_OBJECTID;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_INODE_ITEM_KEY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, r=
oot, &key, &path, 0, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 leaf =3D path.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btr=
fs_next_leaf(root, &path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 err =3D 1;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D pa=
th.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.type =3D=3D BTRFS_INODE_ITEM_KEY) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrf=
s_inode_item *item;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 item =3D bt=
rfs_item_ptr(leaf, path.slots[0],
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_inode_item);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(btrfs=
_inode_flags(leaf, item) &=20
>>> BTRFS_INODE_NODATASUM))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_csum_inode =3D key.objectid;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 } else if (key.type =3D=3D BTRFS_EXTENT_DATA_KEY &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 key.objectid =3D=3D last_csum_inode) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrf=
s_file_extent_item *fi;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 addr, l=
ength;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi =3D btrf=
s_item_ptr(leaf, path.slots[0],
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct=20
>>> btrfs_file_extent_item);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_f=
ile_extent_type(leaf, fi) !=3D=20
>>> BTRFS_FILE_EXTENT_REG)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto next;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D bt=
rfs_file_extent_disk_bytenr(leaf, fi) +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_file_extent_offset(leaf, fi);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D =
btrfs_file_extent_num_bytes(leaf, fi);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D che=
ck_log_csum(root, addr, length);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("csum missing in log (root=20
>>> %llu, inode %llu, "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "o=
ffset %llu, address 0x%llx,=20
>>> length %llu)",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ro=
ot->objectid,=20
>>> last_csum_inode, key.offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad=
dr, length);
>>
>> This is causing some false failures when running fstests, like test
>> btrfs/056 for example.
>> There it's attempting to lookup csums for file extents representing
>> holes (disk_bytenr =3D=3D 0), which don't exist.
>>
>> Also this change assumes that for every file extent item we must have
>> a csum item logged, which is not always the case.
>> For example, before the following kernel commit:
>>
>> commit 7f30c07288bb9e20463182d0db56416025f85e08
>> Author: Filipe Manana <fdmanana@suse.com>
>> Date:=C2=A0=C2=A0 Thu Feb 17 12:12:03 2022 +0000
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 btrfs: stop copying old file extents when doing=
 a full fsync
>>
>> We could log old file extent items, from past transactions, but
>> because they were from past transactions, we didn't log the csums
>> because they aren't needed.
>>
>> So on older kernels that triggers a false alarm too.
>>
>> Thanks.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +
>>> +next:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 path.slots[0]++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +}
>>> +
>>> +static int load_log_root(u64 root_id, struct btrfs_path *path,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t btrfs_root *tmp_root)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *l;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_tree_parent_check ch=
eck =3D { 0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_setup_root(tmp_root, gfs_in=
fo, root_id);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l =3D path->nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read_extent_buffer(l, &tmp_root->=
root_item,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_item_=
ptr_offset(l, path->slots[0]),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(tmp_=
root->root_item));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->root_key.objectid =3D r=
oot_id;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->root_key.type =3D BTRFS=
_ROOT_ITEM_KEY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->root_key.offset =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check.owner_root =3D btrfs_root_i=
d(tmp_root);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check.transid =3D btrfs_root_gene=
ration(&tmp_root->root_item);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check.level =3D btrfs_root_level(=
&tmp_root->root_item);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->node =3D read_tree_bloc=
k(gfs_info,
>>> +                                       =20
>>> btrfs_root_bytenr(&tmp_root->root_item),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 &check);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(tmp_root->node)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tmp_root->node =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_level(tmp_root->=
node) !=3D=20
>>> btrfs_root_level(&tmp_root->root_item)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 error("root [%llu %llu] level %d does not match %d",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->r=
oot_key.objectid,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_root->r=
oot_key.offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_heade=
r_level(tmp_root->node),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_root_=
level(&tmp_root->root_item));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int check_log(struct cache_tree *root_cache)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_path path =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct walk_control wc =3D { 0 };
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_key key;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct extent_buffer *leaf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrfs_root *log_root =3D g=
fs_info->log_root_tree;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err =3D 0;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cache_tree_init(&wc.shared);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.objectid =3D BTRFS_TREE_LOG_O=
BJECTID;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D BTRFS_ROOT_ITEM_KEY;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.offset =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_search_slot(NULL, l=
og_root, &key, &path, 0, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto out;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 leaf =3D path.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btr=
fs_next_leaf(log_root, &path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 err =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leaf =3D pa=
th.nodes[0];
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type > BTRFS_ROOT_ITEM_KEY)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key.type =3D=3D BTRFS_ROOT_ITEM_KEY=
 &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_root_objectid(key.offset)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btrf=
s_root tmp_root;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&tmp=
_root, 0, sizeof(tmp_root));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D loa=
d_log_root(key.offset, &path,=20
>>> &tmp_root);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto next;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D che=
ck_log_root(&tmp_root, root_cache,=20
>>> &wc);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D 1;
>>> +
>>> +next:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tmp_roo=
t.node)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free_extent_buffer(tmp_root.node);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 path.slots[0]++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +out:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_release_path(&path);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 free_extent_cache_tree(&wc.shared);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cache_tree_empty(&wc.shared))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "warning line %d\n", __LINE__);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +}
>>> +
>>> =C2=A0 static void free_roots_info_cache(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!roots_info_cache)
>>> @@ -10585,9 +10853,21 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto close_out;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gfs_info->log_root_tree) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[1/8] checking log\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ret =3D check_log(&root_cache);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (ret)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error("erro=
rs found in log");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err |=3D !!ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "[1/8] checking log skipped (none written)\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!init_extent_tree)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progress_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[1/7] checking root items\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[2/8] checking root items\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 g_task_ctx.tp =3D TASK_ROOT_ITEMS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 task_start(g_task_ctx.info,=20
>>> &g_task_ctx.start_time,
>>> @@ -10622,11 +10902,11 @@ static int cmd_check(const struct=20
>>> cmd_struct *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[1/7] checking root items...=20
>>> skipped\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[2/8] checking root items...=20
>>> skipped\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progre=
ss_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[2/7] checking extents\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[3/8] checking extents\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_task_ctx.tp =3D TASK_EXTENTS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime,=20
>>> &g_task_ctx.item_count);
>>> @@ -10644,9 +10924,9 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progre=
ss_enabled) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (is_free_space_tree)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[3/7] checking free space=20
>>> tree\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[4/8] checking free space=20
>>> tree\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[3/7] checking free space=20
>>> cache\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[4/8] checking free space=20
>>> cache\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_task_ctx.tp =3D TASK_FREE_SPACE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime,=20
>>> &g_task_ctx.item_count);
>>> @@ -10664,7 +10944,7 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no_holes =3D btrfs_fs_=
incompat(gfs_info, NO_HOLES);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progre=
ss_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[4/7] checking fs roots\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fprintf(stderr, "[5/8] checking fs roots\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_task_ctx.tp =3D TASK_FS_ROOTS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime,=20
>>> &g_task_ctx.item_count);
>>> @@ -10680,10 +10960,10 @@ static int cmd_check(const struct=20
>>> cmd_struct *cmd, int argc, char **argv)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progre=
ss_enabled) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (check_data_csum)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[5/7] checking csums against=20
>>> data\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[6/8] checking csums against=20
>>> data\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 fprintf(stderr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "[5/7] checking only csums items (without verifying=20
>>> data)\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "[6/8] checking only csums items (without verifying=20
>>> data)\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_task_ctx.tp =3D TASK_CSUMS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime,=20
>>> &g_task_ctx.item_count);
>>> @@ -10702,7 +10982,7 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For low memory mode=
, check_fs_roots_v2 handles root refs */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (check_mode !=
=3D CHECK_MODE_LOWMEM) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progress_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[6/7] checking root refs\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[7/8] checking root refs\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 g_task_ctx.tp =3D TASK_ROOT_REFS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 task_start(g_task_ctx.info,=20
>>> &g_task_ctx.start_time, &g_task_ctx.item_count);
>>> @@ -10717,7 +10997,7 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "[6/7] checking root refs done wi=
th fs roots in lowmem mode,=20
>>> skipping\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "[7/8] checking root refs done wi=
th fs roots in lowmem mode,=20
>>> skipping\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (opt_check_repai=
r && !list_empty(&gfs_info->recow_ebs)) {
>>> @@ -10749,7 +11029,7 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gfs_info->quota_en=
abled) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_task_ctx.progress_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[7/7] checking quota=20
>>> groups\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(std=
err, "[8/8] checking quota=20
>>> groups\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 g_task_ctx.tp =3D TASK_QGROUPS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 task_start(g_task_ctx.info,=20
>>> &g_task_ctx.start_time, &g_task_ctx.item_count);
>>> @@ -10772,7 +11052,7 @@ static int cmd_check(const struct cmd_struct=20
>>> *cmd, int argc, char **argv)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 fprintf(stderr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "[7/7] checking quota groups skipped (not enabled on=20
>>> this FS)\n");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "[8/8] checking quota groups skipped (not enabled on=20
>>> this FS)\n");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!list_empty(&gfs_i=
nfo->recow_ebs)) {
>>> diff --git a/tests/fsck-tests/063-log-missing-csum/default.img.xz=20
>>> b/tests/fsck-tests/063-log-missing-csum/default.img.xz
>>> new file mode 100644
>>> index=20
>>> 0000000000000000000000000000000000000000..c9b4f420ac23866cd142428daf217=
39efda0762d
>>> GIT binary patch
>>> literal 1288
>>> zcmV+j1^4>>H+ooF000E$*0e?f03iVu0001VFXf}+)Bgm;T>wRyj;C3^v%$$4d1wo3
>>> zjjaF1$8Jv*pMMm%#Ch6IM%}7&=3D@^TvKIIdYjZ@t7T($M|Hz%Cr>ZwJ6sj_bRsY^a*
>>> zIr#q#U>$p<Go1bOhu5#Q<?@08{(UO6n<sqYIY$<RXz3}#&sBuS|AUrsgQ{%?z1>tr
>>> zW^k~hR~HJs$P?zuw_V+%>i2AU4x-C~^RmH%0#2o7VY;D>d@D<+CC=3DJ4l?Bs2d@5yC
>>> z&pKh_V}nG$A*f{hGHlfKeT*E3NA1Q(Nt;TxvV6m2A_RVpD=3D`*t<8b6_KTom1S=3D|eG
>>> z>OMhPCcl7*3tYx)YhtFm-3)~e_SPBasmqw|$jnE_-QZfatuNh^bkJ5yW{ZX7NmD)i
>>> zLKCQYs5y!To5G>tIYzSNigXu|<l&x%JzxMA5aW-t+nod|B!efqr+_#STUo@Xu>wY=3D
>>> z*;zh8-nLPC+GYq6HU^A<Qjkh41{(MMB=3Dp?8i7|;p<cL9o>Q7;56uclyq=3DuCMb1GmZ
>>> zuq5@iwv1^<TQdlj9#Xdq$Vj!1d~GO$P#HmKmPt*t2iPme{8~y6{{T++2nv+X7)Fnf
>>> z`$pgevh)w!LR&hx2a|{sW@ac43(Sl>??<SGJB`t-nDXvSDSY*87<ziAenKb9p4UlP
>>> z*(x(s)OBgD_f*R-*yBUaiD3U<uhy+{P{T&x@o^!9gXa@=3DKts_p@u`Tb)rQcu{)tzQ
>>> zhCXcu`CGkyKuQRy(M0c#fPDWJwyhC`w2mizWqVSf=3D=3DSk-nywG!nJzNT5aM0tVb}Va
>>> zK?^BQbY*CPLeJtG``VF4F@BVWBpSVWDFk`J!cOhagXH=3DGB1GApQ?zsg8%y=3DJ$Fgl1
>>> z)+=3DjFc)g}pALW^HG}wkoY7fOfbZ274b~+dEoA?l%Xzz`P-F)vb1^UziIz|no!02bS
>>> zWPfo?`TiKe8aIuiPilXte381GZ4tQc6=3DY*KS0rehLE^7!W+MOr0AEFmQgw<KSH}Ix
>>> ze4qlov3aIg5e(Oh1%CwTZN^`UI!7g(U;iDFt(>e4XDB-M)l0stJd3pf<XujqB2}MW
>>> z6EY1#$l>s;T1IYy#{A9ljl@Ba_*dh)Qfq@8Y1A#q%p|d;USrIAZ*n1`%ho*!-RYOY
>>> z4j%X?D?CoiaW8A*7aue82GA9jmMGg6Bv&mO#v6uKVw1V~Uu01wXbz(RJN_|xw{`8K
>>> zSfdyQCJOdIwdN%h+Jr{$9!6otgQ8^`lkU4u;5wJlsy#P<D{Nc39m@=3D*OHZ533tvD<
>>> zfb=3Dc>-IWOj%>%mQ@Ja!#!QIOVuluA}ecSFg;*v@<bR@g*YX>1-?kl9WGes{ulrRWq
>>> zTCW@Om{iybhK+m8SiS%n^)Kgk21T`IEW#){Czvz;Fix;5bdkB$BFXimx9iBaRZ9r=3D
>>> zV(H0OD8mK94(j^6gF8)|^i-78H`hR#ebBvFq}>vK6-ni7j1S>*viG^nA7<~Bn2KW0
>>> zw%D36qxTcpO;c2bYwf)K?p#^LFL4Ifq8?kP?#;(Jo8*(twFPRBj*u~h%Ej$X6JI2E
>>> z<L5)YZY#@aM-2sxodox#)=3DG1ycE6A6j?am&HLbKPv@FI{(HAJ#D*V@xG^U`bnRtH<
>>> y%w+Y9$G2sBKv@6)0000tuOhH&%TnS10pSUNs0#q29h=3DIr#Ao{g000001X)@}7Iu~Z
>>>
>>> literal 0
>>> HcmV?d00001
>>>
>>> diff --git a/tests/fsck-tests/063-log-missing-csum/test.sh=20
>>> b/tests/fsck-tests/063-log-missing-csum/test.sh
>>> new file mode 100755
>>> index 00000000..40a48508
>>> --- /dev/null
>>> +++ b/tests/fsck-tests/063-log-missing-csum/test.sh
>>> @@ -0,0 +1,14 @@
>>> +#!/bin/bash
>>> +#
>>> +# Verify that check can detect missing log csum items.
>>> +
>>> +source "$TEST_TOP/common" || exit
>>> +
>>> +check_prereq btrfs
>>> +
>>> +check_image() {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 run_mustfail "missing log csum it=
ems not detected" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "$TOP/btrfs" check "$1"
>>> +}
>>> +
>>> +check_all_images
>>> --=20
>>> 2.45.2
>>>
>>>
>=20


