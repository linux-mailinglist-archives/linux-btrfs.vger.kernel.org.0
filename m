Return-Path: <linux-btrfs+bounces-8640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F03899511A
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 16:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43141F272D7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 14:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D061E0B71;
	Tue,  8 Oct 2024 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mX0W7J3J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978A81DF98F;
	Tue,  8 Oct 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396407; cv=fail; b=aZA5MZSNtTBZppsQcVG/s2SqHo5mjckHX2QhmPDV+IUZ67nw8/Y6yxbzuP+Fypyd+TMLgwdhSl/s4I+iu/HQk5VZXCII/sgFWVy4yVuJAAxDxIYP+fTGqWDDpqXzPY7M4XEcXUo8eq9HezN4/+5JC+7t/IyVESdD7X3UZ7OxrzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396407; c=relaxed/simple;
	bh=Rv4Is4+i0UeyhbBwq/0pwzoDM5IfhVSyQ2dnf92UwqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pJcaAlOvcuZoIPad0mE/ZncaFuEIA0ALpoKnXuAu3lhAmMdLYfX6o5LEEbl72R5gFRJMH62chY2VgnwLSNveVm7chWpb030RjOPbOcsCaELVx1R3rE0sW1XBA4/NdP/K9knLVks1lBe+wrSee/h0dZdD9Hs1Tz1wrmDAm7mhzUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mX0W7J3J; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 498CGSlk030024;
	Tue, 8 Oct 2024 07:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Rv4Is4+i0UeyhbBwq/0pwzoDM5IfhVSyQ2dnf92UwqI=; b=
	mX0W7J3JfTNHyhyQQzJs93t8u1VGkqqd8afos2bVS2qnK46gLlKn84vk1gIwpB2h
	MSIhJz01TtJQg7O2B8HCMUKv00XVMgWQLJ7yYBHfVd7MwvMHEbKdM3E/cStf5KmZ
	7q80doJCz89qFggbU9W8KzLCeRvooTbdeA8MaF+ddnrKSq0pdoWygozLj0f9FAop
	HHF5EYA9LRZ7bfdbtv3l3SKqIkCQmlKEjGdAdC1s7Vq+14c4XbKs/Fh8H1O8Azaz
	/dl9WLVjJR16rlA7TDl9WPZW/uTKEEwFhV1TQNDX21RipM7U70RlFrdG/Z2Tz3Cu
	CiiN3tbVjLGNkWmIyqmApA==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by m0001303.ppops.net (PPS) with ESMTPS id 42314rgmqq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:06:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMGf6tWNH+SR4zLMimID7qIj0KvqzhWraYeguehGEd0c4wp37inmNew36gou2wQBcK/Icd3dHJ+XenG5LxmdeM5KDcNQ4a34wUqHVkCsyRqBnN6JNWJspKUqFx90jLs08Kd0lu+AnDBVCJBy47QZWa8Voq/xK1mxl0DyR4Fz+DDG1QQnm/Tua20Adq3SEt91COKpkBJ8RWZOP/nUX4r3XE9Q1YqUZmmw/w6hJviB405/N6m8h5WBPKJ1hhR0tl8pVaD+wdNlSwf4rrfZmHxUBfmFKr8Y+Y1kJJc6xGTshnb42QRabkL2V3CHWyVPXtnBfhjqWopbjofx42xvCwXrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv4Is4+i0UeyhbBwq/0pwzoDM5IfhVSyQ2dnf92UwqI=;
 b=ivCxcx0FI1EPGndeq/4bidVoFF6xqV5y0Y14MCVRxDkyzQUuzhqYAiUcdDi807+29oWK4PBjhun045jYMLL02V8a34a2pjMcTvIUnw0Q3MV0KystkstzggaHpAGg2QR+JsmRPIEEajx/3DH8b60VACQuj76iZ9VwQiqtFrticBNo7GzznBBJx1oMCAYi/OE1UN7AZ4h+jiV1+YPx+qS08UwLHPujNG8BGssfEfCvHcfI1e86mlIHZL3DiaLxIDA6cI5mjOQAenSP6AP2n4EYIi0HByiB/cZAE+vt013RHe6ryG1bUKRnkfcqmTnFcxHNH9nBoyODdCYyf6Ma+Vtv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by MW4PR15MB4427.namprd15.prod.outlook.com (2603:10b6:303:104::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Tue, 8 Oct
 2024 14:06:40 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:06:40 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test for missing csums in log when doing async
 on subpage vol
Thread-Topic: [PATCH] btrfs: add test for missing csums in log when doing
 async on subpage vol
Thread-Index: AQHbGXR+Yj0MVL+S3E2CBx2A7F4rNbJ82xMAgAAImQA=
Date: Tue, 8 Oct 2024 14:06:39 +0000
Message-ID: <ae203ea9-d5d4-4d25-825f-e017f23b3bf7@meta.com>
References: <20241008112302.2757404-1-maharmstone@fb.com>
 <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4oGiDQ4bahbJmxw9zp8CuzAF+VzJvqqdx10A8qyNk1Ag@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|MW4PR15MB4427:EE_
x-ms-office365-filtering-correlation-id: 77641e37-57d7-42d1-48d8-08dce7a26e71
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tm10ay9CMmNISUR0eGpJTkwycXd1dmRtbUJJYmt3amhwd1hHeTM5Q1o5dEhB?=
 =?utf-8?B?V3pHVjd2M3hlS1JscWtaQ2tDUFpaZGRsSGRrUjN1K0RGMHpVVGJkcmZHOXZl?=
 =?utf-8?B?WWlrdW5xd3AxOVNKQkRCam9JVXdSYWZUU0JyeUdaRWdsdnlEbXhKYU9PcDVV?=
 =?utf-8?B?OVRqS29ML25YTEprdVpyRkJITGRNWmJNVm42eHF2SUJWYWRyeXhNWjF4MGJC?=
 =?utf-8?B?NFZmMktpSk1xd3FjZkRsRnZKR0JralVIeFA3L01oSEtXdjFoU2F6d3VRMmhp?=
 =?utf-8?B?TVB6Z1RxS00zYzZSWFIyRVU0ZW9pazV3dC9obGgxbVVRWituLy9Ccnl6MzRH?=
 =?utf-8?B?N043V1RzdERyVHNTTEJwM1JjTkJSVThxaEp3d2RnZzVRMnltSDFVbjVmcWkv?=
 =?utf-8?B?bUg4QkM1SHI1S3lLQjF1UVdud2hkS0x5QVVjUGNNV0pXeXZBTHZyWXBUZ004?=
 =?utf-8?B?WUZtS2FxbG5kYWxqWnVmeDByR2ZXbnRkK2h3ZUtSanNubmloZ3hzckQyWlRF?=
 =?utf-8?B?Y21CdUxTQU9yRGc0QjFxNHVLSllnU1pKZ201ZkljMVVjcXRyS3ZCNnhNMXhx?=
 =?utf-8?B?MlZkZzJJR1JvTjEvN0loWGd4S3hBOVVZMXJqTEdpUUJQM0s4MUNPRlNpTjlm?=
 =?utf-8?B?TFRpazN1bHdrS2xmWnJlTkRsQkhYTytoTkl4Y0dkSmNYYmlqUU5PaHFzQUNa?=
 =?utf-8?B?WWpLS1BkWk9LWWxyN3BWeUdKY0tXaERJdkFPUC9Pb2VxbzVPalZQSk80S3NE?=
 =?utf-8?B?ZzZxV3IySnpFNm1USHlCdHBQTE1pbFh6Wm9Xd2dZbkluTUY0UTh6QVBaMENW?=
 =?utf-8?B?a1JzQWlzR09DcU0xZUt0Sk1GZklrY0kzcEFLck1GMEJ6aTVJNzdMSTBuQldp?=
 =?utf-8?B?ckRnQUZZNGwvSGs2MEpUaXBCNkdSVVNFaFlUYlF2Z1NxalQrV2Y0NW4xV2lV?=
 =?utf-8?B?cHB1ZWlKNjExSTZlYXFjNXNCN0RSeUpMMysvVnhPblQ4Smt4YlRWLzR1Y0w3?=
 =?utf-8?B?dVBDb3l5SitBb3NBZGI5amhCdW80OVgzSkRKTzZJYVh0Z0FBTE9NMTJKQ0w4?=
 =?utf-8?B?ajJwQ3J5dEY0cEtVRTJmbjJtb2xUT2hDOW1XQ1hZN2Z4U29leEpNUFNKQ2ZY?=
 =?utf-8?B?MHd4ZC9icm1kZ0lmMXRvVmZoUGY4emVHUU9jeUxWNmhhVDIrMHduY1dEN2ZG?=
 =?utf-8?B?dXZ3RGdWbFlCakNpWlRqd1RVMmR6dklqa0xJZmN2dnozc0I5d3MvMTZpS2Fs?=
 =?utf-8?B?NUMxLy9CT0NxZ2h3TkFLYkM2dGVGNVg0TDFGMU82RU9uQWN3SEF6WEFXNllO?=
 =?utf-8?B?SXd1ck5Pbk9HYWV2RkVad3BxeE50U3NhaE9CSDNNR3FXMm1aMjBSbWxtclV2?=
 =?utf-8?B?b1Z4TG1KMkdYa2lLcERWaTZOb2NISE5VNXd2MFBJV2ZFOGh6YVdGdTZZdlZu?=
 =?utf-8?B?SnpkRUl1NURCc0V0Q0ZYODc4Rk5DTUwvVGlqSmpSTy9TeTJCb2dadTYwQnBa?=
 =?utf-8?B?ZkZ1dmlCNDgxRlRJUWdsZjF3Y09rbVBDME5xRUlLNjNXVm1DTHc0a2ViQVNs?=
 =?utf-8?B?UStMME1jeGdoeGdselJDaWxtc0FvTmMzaSt0OVdtdmZHZlArTUdnTFVCY09D?=
 =?utf-8?B?bkFHYXlCVnFzc3BxWVQzc253cTZPcnlXODJuTWFISkRoZ2xLRUFyWk81eUIx?=
 =?utf-8?B?aVRldlJqck40bG96Z3ZJNUpGVVhVQ0NxeU5iSDFKcm1vbmZVQlNWUE9vMUpP?=
 =?utf-8?B?K2c4RkNRNG43dXdsK1dUMFFRL2srVDArR0FsZ1o0NTV4cSt4M09CTFBWS0Fw?=
 =?utf-8?B?d3BrdGJENVYrSFdiWlcwQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDg4RWNJQWNwVmFlbzBlS3cwV3B4MjY2Um5vL2dwZDAweXlTVUNhbTFuVGIv?=
 =?utf-8?B?dFpyQ3NmRkw1YkJiUVBxQ3dOdVYvenNibkFFZWdsYlQ4b2hBUXZjb0ZpOU9N?=
 =?utf-8?B?NXVSUWFPTXc3WlZzMW1qQ1haMGZFZEZKYllwbmgzMCtteE14Snpsd0UrdXVY?=
 =?utf-8?B?YWQzWityaTdwNEtncW9Ib0VDOWtrWmljS0lYa1BVaHFjQ3lyUGZwYU5oNmRQ?=
 =?utf-8?B?RGJlbWNIdE41SVNjOHdoNk1PbkhHQkxTb2QzRmQ3L0lkKy9PWWZsUUNaVDZq?=
 =?utf-8?B?TEpDVk1rWU1VcExxYzV5SzhjUFN1OGlSa0hTdWFLUm9OSXFwdmFYZ09BU3VG?=
 =?utf-8?B?dFFTbEVGZHJUWXNXbE9Zd2E2aHZaQVFaaklwZmkzTUF5ektwT1FDTWdDbGdK?=
 =?utf-8?B?RUNiSCtrUGR5SnNGREtsdUVDUlhxOXNRRCtpampxWXNrcHdvVHViMmJudzBv?=
 =?utf-8?B?NE1aTzZRUzY5OGg2dzVuaUZPWUo5MzNBQjNnWlVPY1Fla2VzNHozdExzQVlP?=
 =?utf-8?B?NGZuMnFsVjlxbHNFcENoVHJEUXhPa0lDTzI2UmVMZGU3MXdZU0lvV1F3NTlo?=
 =?utf-8?B?VFZWNHhQM0FiMUVGTTN6c2g5V0JueVdpTG04bU9LOC9NNW5sMVVIY2swQ0t6?=
 =?utf-8?B?Zk5kWHZjTTdVMXZPalRQcStuRUc1SXdrU0hoK2pKeFpWSlJ4aFk0U2NnZmRT?=
 =?utf-8?B?OFI5bE9yb0ZZQjFhQ3RTdDJDUnIxbXlCam1SMTlIM3k0RUZVOFFvNUhoU1l4?=
 =?utf-8?B?aXUwMXVCYUJQY3pCQ0tTVENFYjd4b2FBeVFqdW5nd3ZRRlZHOVNIUG1IYXhE?=
 =?utf-8?B?NVVPTjljdWlVNUhaSC9NaHFhVUcrMnc4bzIvMzVTdzNaRmVyRkFPbmNoVm5n?=
 =?utf-8?B?bHl0cUNWRUYzR0tZaytNSG9zQm9mT09ZSFJ1L3BycW03SmEvS2RCdjR4WTdJ?=
 =?utf-8?B?SFRDeDRaQVhQTXBrQXd0eEhpWG1iNkp3OWh6RkJuck92TVFxWGhJWFZpa2pY?=
 =?utf-8?B?ZHRBeTFWSWNLUTl0SHl0bGlGQ2E4L2JEVFIxaXZ5Rkh5N1Y0U05hZ0VBOEEr?=
 =?utf-8?B?aHAzKzJ1U3pYMDR3T05yWkE0MktRZVVBYmpZLzhOaTVmUDdtNFJnankzVXM0?=
 =?utf-8?B?SnJ4c29US3JNcjBLS2Y2bTF0OVZNVnF6NzRIUHdSMXlXdzBsME93NEhTSElN?=
 =?utf-8?B?V1o4SXlyVlFLaVVib0x3bko5Y3ZwNk5wTTVZdjZLUVlpS1pma3NMSUJkZ3dS?=
 =?utf-8?B?K3RnbGZ0TWZkSHlGb3d5QUd6RWpPQVdnc2hZeTFJTXJieCt1a0d6aDl6YmIr?=
 =?utf-8?B?bTgzYThpQzV3Z0ZJMURDLzFLYmZVNHRBdU9na0tWRDJiQnRUQUJ0MGxJZWt1?=
 =?utf-8?B?LzNneVVUa1Fxa3E2NGJDMGpEMklvL0tGQkl4ek9DYlpHM2ZXYmJJcXZ5OUxU?=
 =?utf-8?B?eUp0SnBoNUJnSnhwVCtaSVJCZyttN3MzVTNnQXVsd0xIRy9kc3g4OEl3c28y?=
 =?utf-8?B?MW1JejVCSTNYZThkdStxNnFLYUVaSmtmc2ovRElBUlhnV2dQNGdFNTQ3MURV?=
 =?utf-8?B?VjhTODJQcElZWmFhVnYraUVPRHhocUJwM241bUdaOXEySm52RGdRbWRuRHF5?=
 =?utf-8?B?SFRHMloya0k2eHYzRUNadXBBUys1L1pTdGVGQ3J4WjR4MnhEU0NZVCtGSGtu?=
 =?utf-8?B?ZlpldGpIcXFZU0NnNHVLTnc0aDd1RzNBbVZVMnNQR0JRZ0pSa1pIY0llRERx?=
 =?utf-8?B?ZjUrNFBYZGdxcWxYOWZjTWtMY0ViREpXek9WQWkzaTZBUXlOVXJiak5GVkV4?=
 =?utf-8?B?ek0zMExLMit0eVM2NnhUamp4OEJqU2Z2OS9VTXpvcGhSTytPMitFRndUSTU4?=
 =?utf-8?B?VWx3MGVoR3NMejNxVWlucklEeUFONjhsY3k1ZEUvWXlJR1dEK2tSVDJicjBC?=
 =?utf-8?B?TDhkNTNOL2FmWmhPMGo5YnlJWVpYb1RwNHMyc0tKWGY2cVE5Y2orYzdSbXR0?=
 =?utf-8?B?c3pBNGVSVEp4V0ZjSC9GMDlKdVdYSldSaXF0U2NZd29DUjZQRmxRWmwydEp3?=
 =?utf-8?B?dWZldG5FZ3lTZXNnM1QySFVvS3h4dDNybHJqdzQrYmdBKzZXZ1J6SUZrV1cr?=
 =?utf-8?Q?byfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <897E106AD528A6488D23F952D3A97E40@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77641e37-57d7-42d1-48d8-08dce7a26e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 14:06:39.9535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sSoUr10kRFg90wf1R81k5hyle9M9dB6abHICxnUZQDBOdueQqGyRsfXxOePAx43OadfZw+jdAO+4mUTvlxaW8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4427
X-Proofpoint-GUID: 5tMNr5LiAkAZ_UVQPVP78R6qst0LcVaP
X-Proofpoint-ORIG-GUID: 5tMNr5LiAkAZ_UVQPVP78R6qst0LcVaP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

VGhhbmtzIEZpbGlwZS4NCg0KT24gOC8xMC8yNCAxNDozNSwgRmlsaXBlIE1hbmFuYSB3cm90ZToN
Cj4+ICtfYmVnaW5fZnN0ZXN0IGF1dG8gcXVpY2sgbWV0YWRhdGEgbG9nIHZvbHVtZQ0KPiANCj4g
V2h5IHRoZSB2b2x1bWUgZ3JvdXA/IFRoZSB0ZXN0IGlzbid0IGRvaW5nIGFueSB2b2x1bWUgbWFu
YWdlbWVudCBzdHVmZi4NCj4gDQo+IEhvd2V2ZXIgaXQgc2hvdWxkIGJlIGluIHRoZSAicmVjb3Zl
cnlsb29wIiBncm91cC4NCg0KTm8gd29ycmllcywgSSdsbCBjaGFuZ2UgdGhhdC4NCg0KPj4gK19s
b2dfd3JpdGVzX3JlcGxheV9sb2cgbWtmcyAkU0NSQVRDSF9ERVYNCj4+ICsNCj4+ICtfbG9nX3dy
aXRlc19mYXN0X3JlcGxheV9jaGVjayBmdWEgIiRTQ1JBVENIX0RFViIgIiRCVFJGU19VVElMX1BS
T0cgY2hlY2sgJFNDUkFUQ0hfREVWIg0KPiANCj4gV2h5IGRvIHdlIG5lZWQgdG8gZG8gdGhlIHJl
cGxheXMgdHdpY2U/IE9uY2Ugd2l0aA0KPiBfbG9nX3dyaXRlc19yZXBsYXlfbG9nIG1rZnMgYW5k
IHRoZW4gYWdhaW4gd2l0aA0KPiBfbG9nX3dyaXRlc19mYXN0X3JlcGxheV9jaGVjayBmdWEuDQoN
Cl9sb2dfd3JpdGVzX3JlcGxheV9sb2cgbWtmcyB0byBwdXQgdGhlIEZTIGJhY2sgaG93IGl0IHdh
cyBhZnRlciANCm1rZnMuYnRyZnMsIF9sb2dfd3JpdGVzX2Zhc3RfcmVwbGF5X2NoZWNrIHRvIHJl
cGxheSBpdCBmcm9tIHRoZXJlLiBJcyANCl9sb2dfd3JpdGVzX3JlcGxheV9sb2cgcmVkdW5kYW50
IGhlcmU/DQoNCj4gVGhlcmUncyBhbHNvIG5vdGhpbmcgaW4gdGhpcyB0ZXN0IHRoYXQgaXMgYnRy
ZnMgc3BlY2lmaWMsIGl0IGNvdWxkIGJlDQo+IG1hZGUgYSBnZW5lcmljIHRlc3QgaW5zdGVhZC4N
Cg0KWWVzIHRoZXJlIGlzLCBpdCdzIHJ1bm5pbmcgYnRyZnMgY2hlY2sgZXZlcnkgdGltZS4NCg0K
TWFyaw0K

