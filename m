Return-Path: <linux-btrfs+bounces-6064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D891DBBC
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1291C215DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40492127B62;
	Mon,  1 Jul 2024 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kAjGnHjd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARx7dze+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245F72C859;
	Mon,  1 Jul 2024 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827334; cv=fail; b=mVtqBgwkQ09NZsb/pHNA11+OSDxzG7fI87Sg24ojdTv3K7GmhtY6RrJYPsnXsEekf0og8+0eHBJAUxAHPk0cfKaZZPqqKTdTUCWaYff/NRPeOGc3/HP6jfBdqsMEqJAYc2V+NRweOibTEeomXhEeDCwwJW4dnZaMItmsA6tDeHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827334; c=relaxed/simple;
	bh=/0wmAL38QbSCfHUkO7RwnJP95Z2svRr962smx/h2/pc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lqk/bDgECdGHDoU4xYEYaZJDZOgk2G9NW4F26dvjf13nta/Pdooi9uAxVh1NDqLPlSIiUF2m2Y96k/yd3Pg0B+wD0ZOc6sNB/yaJAf14uXvXBGZrfyyfDPnKhnsUg/b9TTW5wieXIJaadSIT8RG7eT4iondPcswDpUtnUTn8Dww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kAjGnHjd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ARx7dze+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617tY3J013150;
	Mon, 1 Jul 2024 09:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pMPfr2AmMGgzzRlesao+FxlxVBDGpXYOnOnSZ9ZTnmI=; b=
	kAjGnHjdW8vgtu8shJg2zaU4ZfNRfBldBQzX+BSsChDmJT+x6KpGW/aS9Tt3z9mM
	4DQTvFGdO8aSdD2oET8yesg/Iylhd+/anOo9payU9Q4+jXPAam7dF0+IUaQDvVMf
	8THnn8jZ6ls/PfeDEZZAj5O6glersqhwbnuIziA5Js/oe8HfztuK+fseF6ZLn5H2
	izCCGnpuPsIItSTrVQqZTq0fg/BTrZbe3ieFaq6thY9adXRF1HUuGj/IAmJipoqD
	d95L7T7VC32HFfSARgxY742PzNqDtDoJhAbPgpKUWZP7WOx9drQbbliidOHFjyWI
	JJR9+2DWJ8Q3bEXUf25kpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40296ataxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:48:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46189jF0022913;
	Mon, 1 Jul 2024 09:48:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q60drx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 09:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyrl1kX2AXavs0XX0LhMtpWbyyXoR5IvNBzkZzbv+NQ2kgO+QrtkCHuh1pOh16SoV8IDU9G0zym/iui0inAgRE4MsqQkC7upMvQ29cRzIC9u4TsSfo5Rjxlz+BMCpwG8NZJwSZ2Ro40l6jAxrtShd+JKL5PptTLAKiB/SJYcbrnaoYWRo+2ces23/RuKIkmj+e7TEDtPAEI7TQs18HBjxsXnO68XHxuiNgXzFGvYB5Omct1WhcSm3JDvfDyYLiJqxEg2lTc0GNZHsTRdhqkBDQkvlSRlCsehyK1MNP5DzDOm/dkKU6pL/hl/tQirjhCJWHajeh6QUmwb+l2axmpHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMPfr2AmMGgzzRlesao+FxlxVBDGpXYOnOnSZ9ZTnmI=;
 b=JWV7TdFJiiWW7u+H1//rc5NUKqCrW76bzY5fmpZgaK64q+BI3v/hMfqbGM0RkMFXD47RRBxjWw+MjGR/P7Y0MGvplhiOmMBHn4v72PIEVoNdcsXx8sbDZ4pNMv/2v0sUaqqOyR5iGIrhD3r097NAxkH/x+9Kua5vCZ0tik/MWHT5uWVGdWsh4K+yUSVWTNTYyNt8j7AjJ8NOk0sSW6kTeVdi981a23eCK6gxAUbOdlufVH/QhOdnymMKupBIHDCH7ZcRqAMn97ALceNEk3aLCfX+jwSM/syTdCZ8CQuLTwDhVWTZ40w/94NuUSEQF32W2sy2Is0k8VBSrYuTo1Z73A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMPfr2AmMGgzzRlesao+FxlxVBDGpXYOnOnSZ9ZTnmI=;
 b=ARx7dze+diWslqZKXJhEZAPiWyHAH/x3OEBmZzxKVoBK2VnXpeFVITi9oPA/eDVRYXlgKYAxlAPqQaef7Dp/9nnAGab3YX5ITjKJcIEQyTK1FS3wEKjetuM0G8tCgFeyhnA1WUN2H+CS98PpXChgxXPnyB2ToSau5Nr+FkaFi3w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5676.namprd10.prod.outlook.com (2603:10b6:510:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 09:48:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7698.033; Mon, 1 Jul 2024
 09:48:39 +0000
Message-ID: <818b51a6-6ac3-4a2f-afa7-42568227db65@oracle.com>
Date: Mon, 1 Jul 2024 17:48:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: update golden output of RST test cases
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240627094722.24192-1-jth@kernel.org>
 <CAL3q7H5coRxND9EwUkzOyLSp2cLKWirbEueiuATegytfBChRaQ@mail.gmail.com>
Content-Language: en-GB
From: Anand Jain <anand.jain@oracle.com>
Autocrypt: addr=anand.jain@oracle.com; keydata=
 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
 y4F0QrzFk5Hg4pvnpDur6Cbp
In-Reply-To: <CAL3q7H5coRxND9EwUkzOyLSp2cLKWirbEueiuATegytfBChRaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ee3acb-1db8-46b0-8670-08dc99b2fc10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWszamhjc0hOK05vZTI5NVd2Z3NUSm13OUpIbzBOOWo4WVRjTUJ3RGxXS3FB?=
 =?utf-8?B?UnFOOWRHSlNidGVFSXpFZVErZHdKdXNqMi90L24rTGVkMnNKTmxkYkYwVkZ2?=
 =?utf-8?B?djJtamQveHI3RXVVWEJLLzJNVmF0NkZtdFF5bEtiN1lMRXBqLzgvVzFLc2JM?=
 =?utf-8?B?RXllOUNBYnlnTDEwZnEwKzR0WG42bGx2K3JFOFh4VWVYSWp2NUZJeFRtK0Ur?=
 =?utf-8?B?V3ZRKzhxTkZVb2VRdTVnT0pHVjZLYnhiN1pYb00vSGI5UTErMzI4TTJ4YUJ0?=
 =?utf-8?B?WHRoZk9vdGkrK0Q4RnFiSnRyRGxSWENhcS91WENUZWpQcUlJbzRPV2drMVJU?=
 =?utf-8?B?UllGVVpkU29ucjQ5M01xaWlNaTZNU0YzK3d6TXpBSmwvaHJ2aHgzZzFlazJv?=
 =?utf-8?B?RkJIcE1YSnAwRjFtTldTenNuTnh5RTJTMU85djYzenl3aXBYdkNLODNCeE1x?=
 =?utf-8?B?by9sM3dqSEhPQ0o1OHgwbGNRSDFkMXRPTVloaEk4eUx2eGtmMUhERzRkZjJk?=
 =?utf-8?B?NHBjaGwwMnBnaUVKUGNxMjJMZHdjKytEK2VBVVhwSFplK1VBU01EYjVFRkhO?=
 =?utf-8?B?RnVJbXRPb24yS1U0OUpnWDU5d0hGUVVldVZtZEFPYUVqb25mWkt6Qi8rVURQ?=
 =?utf-8?B?ckRWMnFyL3YwMzVsdUU0NFpSS2xqdm1LN1RHUzNHQnlRSzExTXBuNWdKTE5Y?=
 =?utf-8?B?RnBPVWU3aWN5OUFXUkt2WHZqejdPVnB4dWdnbnFiUFhJcmxGdU1wdXFMTC93?=
 =?utf-8?B?MzdLb2ZqcmVRMWc5YzRZU2xBRlBYai9PRmlpeDQ2bXRzV0FHN3dvVGVrVmha?=
 =?utf-8?B?Vjl6QzFKNzhoSE4yMGpUdys3bDBBbmtuQ2FNSEJuSERuWDB6T3pRc0FINnI0?=
 =?utf-8?B?OEVuWG8vMDBQYlNZOEYvM0wzcU9YSDVSSTVKRnNIajNLVy9xOGtmdHpRTjVK?=
 =?utf-8?B?dDc3RXlJTEM4QkM4NWU0aVVMMHh5bkJTd1VQVGtqNW5iRldhZVdVOVJ4SDFJ?=
 =?utf-8?B?TndnRE5JZGtEOVcwSE9FTzdjSkp2bThGelFVSE8wMmRGcCs2eFRaek1nNzZY?=
 =?utf-8?B?QkFXVXNXdFpqb210M2lGWExuTjJsYmJuSWpuSGRLblpHU0NocFBuWldtMnNq?=
 =?utf-8?B?UDJNaHM3ZEo2VXNvcFduT3FUUXpTL0hINk4wY2JZQ1RHdWQ1bzE2L2dQaU9r?=
 =?utf-8?B?OTlNYnd6YkI1dCtXbzMwNnI4eS8xMzN4ejNIR2lrMUxTWjhGOEw0ajc5VzNP?=
 =?utf-8?B?THlwbi96aXBVcy85aEp0V0lVdSsrdXl5MW1LMTRiK3ZYMzF2ZTl6cDNyTFhp?=
 =?utf-8?B?eEc2c3gzbGZ4eEYzK1EvVlNoNTRhd0hhSDFOd3g1UUFucFkyblo3RG9Wbnlt?=
 =?utf-8?B?bjNkTEQ3SFFaMlZWQUhlRkdyRHRJMTBaZkdvcXBCUHFjQ3JpMUIwS0Z5SUE3?=
 =?utf-8?B?ck1sN25IUW1XMG1PNjU0N2FSQkcvdm5uNEYva2JRT2tONVAyU0lHZE9WaUUv?=
 =?utf-8?B?RGl0V1ZHdHpBcng3d2lUQVhPVW9NY2ZOZDlaMFpFSTFEMnovTmpPNTIyZGk2?=
 =?utf-8?B?Zlg5YkFtSVVtaTJKdVFHNzFOVkxkOGRacG91OWxFUERFSFZGa0NvZU41V3BX?=
 =?utf-8?B?bWQrNHFPTG9IZlprSHBvOGg5R0xiczlzcDVQUnB0NFBBUitzdFRmaGM4dGVw?=
 =?utf-8?B?QllFRUEwNWkzaWhrSXlIRXZMSndERDJubEdsV3k3ZDRDT2pOWCtMa1V2Vk9M?=
 =?utf-8?B?anlhUHRyeCtSNlRXUFBJRHdDV2J0WlJwY1V5ZlllN1pJcXh3VjhmTVpHVGZ1?=
 =?utf-8?B?QjdnZkppMG9SWmVEN1RmZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzc0TmwvK0FoVDVXd2I4Tkl0RGlZcnhGeThoRnA4Mmk2SWh1VHk4UElDa25P?=
 =?utf-8?B?aTRyeVVKaEswbm1DR0VzTDAxdzhIc01LU2MvWVhkTEkySVVjVGRCQXU3NHZW?=
 =?utf-8?B?WFFWaDEzVjhPZHArQW9KUjgrOHU4cW1zaGVDZmhLVFU5bndBYkxKa2lMaGp4?=
 =?utf-8?B?N0lSU3hhT3BrVWhsWFVBUmNyTm5XVUxCdERnejk3dXFaRFp4eE9IcGlEdUxa?=
 =?utf-8?B?ZTFzUW44VXVpdmprZDNpUlRlV3VUTTEzV2xEMnY1ZVloQlhmRFVXMFNFMkdY?=
 =?utf-8?B?YTh4ZFNJd0xnQldBVDN1V2trdTJad3l1VGhIM0lsOG5udFBub3hmc3NFeTlm?=
 =?utf-8?B?c2NROU9GSU5BRC82cndYanI2ZzN1TzRtWWhnNUNDSGxWaGtBT1FQUmw2Uktu?=
 =?utf-8?B?U2Y3bm5taTdhYk50cGo4eER6d3VHSjQ0ZlVhZ3dCL1BxdlhCam9BdEhaL29S?=
 =?utf-8?B?Q05sQXhCc0p3UXUxQ0FzYkw4TXUrSWljSDZHOGxvRzFCZ2pBMXViUlBuVnov?=
 =?utf-8?B?bTI5bk1YUFVrcGVKc0g0enF4SGFWVEprbFcyZW1rcHY2MGY1SmxnaldMN0F1?=
 =?utf-8?B?OHVWVzdaNDcxZjRVYU5xdUcyZGU5YnpsZktnWlV5SDBoc2Qrc2ZMdGRzV0lr?=
 =?utf-8?B?U3ZiSnVtcWpOeFVwQVduRkxsTlZhV1BGckZOSk00R2MwdG9kQ0k4ZVQxai93?=
 =?utf-8?B?SDFEV3JiTkhkNEJVNFV4Wm50RitNUEJscEhkUmJkaUtHc3dBOG9GODQyY2ls?=
 =?utf-8?B?VFphRjhBTUk0eCs2SXV0YjQrenpDcGFIWlhDMmFZTWE5VDc0d1NvSmVFbVAy?=
 =?utf-8?B?ME14QjhmakZ1dFRTMldTRFJxOTNYRENTcUNvU0VFTGh4MUFsejNvSWxXbVJx?=
 =?utf-8?B?OW5yeHBkUWJnK0owYmd1THZpcC9LM3NYMnR2ZDJwR0lXUEZwZFpDSWxUenhq?=
 =?utf-8?B?OHo4NnI0QTlvMjVQblN5RnE1Q055bkw4TnJMK0psenVVSWxwVjNkNnRiOUhZ?=
 =?utf-8?B?VlczQUwwRENyNXhQZXhYZklQWEV3dWdWWUgyV3RBQmpzOGhyTUZXUm1FWjR4?=
 =?utf-8?B?NWE3RGY1MmxheWU5bzIzRDFPZUw0ZWlDVWs4VHdyZ09MRWpGYVRtM2tKTWUy?=
 =?utf-8?B?bFVYZ1ljbldnOWtrRFhTbnh1NjhYanpOZ05mRHhzMlEySnM2RzRZa0pCZmdy?=
 =?utf-8?B?MEdPQzRnWTg0bFk4dUhndVU4cWpjaGFOOVNyVWVYNTk1ZDJYMy8rTWhxL05N?=
 =?utf-8?B?ZjAyemZINThaU0kwNlhBUUs0MHRCa0JJVWVIdDFWbDNxNWhUM3BMMXhBMSti?=
 =?utf-8?B?UnJ6SXJrbk14bEpUT08vdFdrTHhDMUVET0xCaXhYWDBSVmVaZlFXK2hVTjdR?=
 =?utf-8?B?NCtDakRYTWhtNUtFOHZ2WXplZFM4MXppai9XNjVMcDZ2VElBV2N1akFkcm1M?=
 =?utf-8?B?dGZ4VllIbHVjN0wzY2JVQXhONkplNlVuWmZIamxpWmt5Ym9wQlBKeS9VLytn?=
 =?utf-8?B?N3RmQWFtODZwdHZHU1ZOZlNWbFhZM01jOWI0V2Q3aXc3MEdsODZDbnF1K2cx?=
 =?utf-8?B?ajJ3eklXdnMwNkZMUUlDcG1aSVBIdDd6LzArNXJWSW82SmRBU3BqcGV5T2RX?=
 =?utf-8?B?UDVWRTR5ZEttYVljZHkxKzBVRVg1bmtwK0t6Yi92MSthRUk4RWVIRktSV2Vx?=
 =?utf-8?B?VnlaZGtjc2lrQXNZTFNLbVVRSHFzRWsvQ1NiSjlyQVFWdXlSWWJsZUxMZk03?=
 =?utf-8?B?V2I5VXFCSVd6enV4RS92RVh4VGwxMGU5OVhOZ1FtRUFRaVFMZDF6ZzdhNXA0?=
 =?utf-8?B?ck9RK3I1dW5udWcvdm1FZURDOVVzMXVuYkVCSlk1MWJJVGY1TTZiemx1WTE5?=
 =?utf-8?B?Q2FLSUlwQjlGOFh1dGJsdG5RbDBXUmhJekdPMmJxeFFWTG9LdlBqOTBTMC8y?=
 =?utf-8?B?bURkTE84a2hTN1cyVVU4N3YrQUZSeW9DdHVLdUJnK0l0TUpleEtQYVR2UUZK?=
 =?utf-8?B?RVBYYitlUUhnamdFWDBjcnVYamFMTGJUcGVZdVJJaVpxaW9UcUpkSlZhU3Y3?=
 =?utf-8?B?dnFWRXlCL1crSnVuQytUNWJLRjd3UFVVeGgvS3VmaFFUdE5OQzRRbDJDM2h1?=
 =?utf-8?Q?qblK/KlTdq6fekIIvpW11v0rs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+5nSV1EP9HmcKQNGeip+d5yPNxePsZKobEKe5x5T+w84lbfisArBSEwzH/dKdU46beX71FaanPcxfbsXGom2qm4QyA6VIfY/oRx16i8JpkCRdn1Dbuc1FLyKFuvWfltGUhT0fHRFj21Tawls+EOZsqxYNEN/LPYx1UpJgu++cpCoRGgvjNwAs1Vow4GtiHJP6jEvBlHQEEsmJsWYnzBfkzAkaiuZD42+KVSE0Ot6I+/9pzCn9NCfCtgpQs/0vcVYFa7kpTbx/xnDgvlFdZW1EAw/DIsyPc1TUG7Kdwvf5/35DF7YeUdUyqokosf4Pf75c4zXKWbNV+Fw7P90GdM2S1pqgYyaZZlIL2c58FvTAWuAOvShCKq6aNSVrt/dZvnfo7aln32s4Acqp/vis8oYjXnIGXylkRew8r9IVrtGAZXDhZRiCH2bElprEpv0aClVBliu09CYR6y09LcmXQbY7f2CDoeqi/Dr58PFUkcS82bzRnz2+5lKt7LLs8GtgOsdxA4yoVvsuN5UMsMu7OdHF6lmTUVexu9xefajPyomVS7F+L0Ss2nuivS/cSZvQEGgoYxXVXYh+H6wfZ0EKkCWq3aMGj58wPofGAFC4FMAMM0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ee3acb-1db8-46b0-8670-08dc99b2fc10
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 09:48:39.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgoz4CRspGtz8Kjsqw8z0FIky3sz5rCiRSu0lEoXGs3qvk7JVRmkXUKwx34aGOW7kzUxH3A+ac92UnH1/9Oprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5676
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407010075
X-Proofpoint-GUID: x5hP9Z5GstZ4w4F6UQUGWj3oLLZ08OGo
X-Proofpoint-ORIG-GUID: x5hP9Z5GstZ4w4F6UQUGWj3oLLZ08OGo

On 6/29/24 18:50, Filipe Manana wrote:
> On Thu, Jun 27, 2024 at 10:47 AM Johannes Thumshirn <jth@kernel.org> wrote:
>>
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> Update the golden output of the RAID stripe tree test cases after the
>> on-disk format and print format changes.
> 
> Better to mention here that the on-disk format changes happened:
> 
> 1) For btrfs-progs 6.9.1, with commit 7c549b5f7cc0 ("btrfs-progs:
> remove raid stripe encoding";
> 
> 2) For the kernel, with the patch "btrfs: remove raid-stripe-tree
> encoding field from stripe_extent", which is not yet in Linus' tree;
> 
> And that we don't need to ensure compatibility with different
> btrfs-progs and kernel versions because it's an experimental feature,
> subject to changes until stabilized.
> 
> Other than that it looks good, it makes the tests pass with the
> for-next btrfs kernel branch and btrfs-progs 6.9.1+.
> 

Also, please rebase on the latest fstests for-next.

Thanks, Anand

> Thanks.
> 
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   tests/btrfs/304.out |  9 +++------
>>   tests/btrfs/305.out | 24 ++++++++----------------
>>   tests/btrfs/306.out | 18 ++++++------------
>>   tests/btrfs/307.out | 15 +++++----------
>>   tests/btrfs/308.out | 39 +++++++++++++--------------------------
>>   5 files changed, 35 insertions(+), 70 deletions(-)
>>
>> diff --git a/tests/btrfs/304.out b/tests/btrfs/304.out
>> index 39f56f32274d..97ec27455b01 100644
>> --- a/tests/btrfs/304.out
>> +++ b/tests/btrfs/304.out
>> @@ -12,8 +12,7 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>>   bytes used XXXXXX
>> @@ -30,8 +29,7 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> @@ -49,8 +47,7 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 0 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> diff --git a/tests/btrfs/305.out b/tests/btrfs/305.out
>> index 7090626c3036..02642c904b1e 100644
>> --- a/tests/btrfs/305.out
>> +++ b/tests/btrfs/305.out
>> @@ -14,14 +14,11 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>>   bytes used XXXXXX
>> @@ -40,12 +37,10 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 1 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> @@ -65,16 +60,13 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 2 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 3 physical XXXXXXXXX
>>                          stripe 1 devid 4 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> diff --git a/tests/btrfs/306.out b/tests/btrfs/306.out
>> index 25065674c77b..954567db7623 100644
>> --- a/tests/btrfs/306.out
>> +++ b/tests/btrfs/306.out
>> @@ -14,11 +14,9 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>>   bytes used XXXXXX
>> @@ -37,12 +35,10 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> @@ -62,12 +58,10 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 3 physical XXXXXXXXX
>>                          stripe 1 devid 4 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
>> index 2815d17d7f03..e2f1d3d84a68 100644
>> --- a/tests/btrfs/307.out
>> +++ b/tests/btrfs/307.out
>> @@ -12,11 +12,9 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>>   bytes used XXXXXX
>> @@ -33,8 +31,7 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> @@ -52,12 +49,10 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 3 physical XXXXXXXXX
>>                          stripe 1 devid 4 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> diff --git a/tests/btrfs/308.out b/tests/btrfs/308.out
>> index 23b31dd32959..75e010d54252 100644
>> --- a/tests/btrfs/308.out
>> +++ b/tests/btrfs/308.out
>> @@ -16,20 +16,15 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 2 physical XXXXXXXXX
>> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 24
>> -                       encoding: RAID0
>> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>>   bytes used XXXXXX
>> @@ -50,16 +45,13 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 1 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>> -                       encoding: RAID1
>> +       item 2 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> @@ -81,24 +73,19 @@ checksum stored <CHECKSUM>
>>   checksum calced <CHECKSUM>
>>   fs uuid <UUID>
>>   chunk uuid <UUID>
>> -       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 0 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 1 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 2 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 3 physical XXXXXXXXX
>>                          stripe 1 devid 4 physical XXXXXXXXX
>> -       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 3 key (XXXXXX RAID_STRIPE 32768) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>> -       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 40
>> -                       encoding: RAID10
>> +       item 4 key (XXXXXX RAID_STRIPE 8192) itemoff XXXXX itemsize 32
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>                          stripe 1 devid 2 physical XXXXXXXXX
>>   total bytes XXXXXXXX
>> --
>> 2.43.0
>>
>>


