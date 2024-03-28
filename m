Return-Path: <linux-btrfs+bounces-3721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6DA88FE50
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 12:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AA9296346
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 11:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301A87E79F;
	Thu, 28 Mar 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jj5o/Owt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RHvz9liS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D97E582;
	Thu, 28 Mar 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626400; cv=fail; b=tiZwG5pV5l3nraVsSpIXgNukI3YOBOSInBZ7vZjd0nBsqDWM2juBtv69iQYONJT1Pyw06Pf+tAok4Wpy9BLQvnYsLih7lDDWsMlI822ngQUeD25kbDwE7RiZ7wZOP2vZZMiH4bsFS6e65futApG37QnuY4jiHUgNRCx9ltupqvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626400; c=relaxed/simple;
	bh=mn+euDTrWjObQkuxaZjKnU3w9mRqWxObUu9kQ9SG0+A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IUTpql0qySDCHlRYpzZnhCAlJ7ZEwZbbq6m7EeY49fenzI+vmZ6Z9lmR6X75jFbd/7FXDKLEHgOZRmaZ/FksQhL89V7zRN/l/CZl38XCexBSCV2StvqsLMejd5E8lLpALGKMwYUBUHZ3IU9l6Vgzr/sJZLJnWTZm8A8+OjbofTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Jj5o/Owt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RHvz9liS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42S91CEd011835;
	Thu, 28 Mar 2024 11:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BxutnPQ/fXVcXPFOm6WArwDNER+V6sF+Gt7vxbeQ8LA=;
 b=Jj5o/OwtI1HIn9LOVm5DdQ+mg0istn4mRGtRZfbWFIr3jcD5+FWSqPJ9zPM6FvHaD7TK
 NKIQMSx0nLW41C2CbNRGnm4kDrrJyvNcl0K/QeYn5UxVA/+131asqqr0to5UI00Z5ouh
 Kb/ov7YsstoTkc7lrVQvEFqiktLpy9KAo+nyP3/AU0EZw70FufIyZ9farccjUp3JXGjv
 0jPgDqaaBWCLVGyn2XhxBaA6GEdUZKAvsLY4KMR5BP+b2+WNNzVLnXfGFVYNRoHRsjvZ
 fYpyFSK8grPfBxON4xQDaEOdhni/bmwUyskEbZ3U1Gui1Z+ggJezX4gFLbm3BpL6CxGK kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gyy4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 11:46:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42SB4a67012791;
	Thu, 28 Mar 2024 11:46:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh9tuga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Mar 2024 11:46:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPdL9kFVuAzmQWea5OcRtzERwplS3R0/YUiQ4CGv9Bi1HDuFCftKFrQNQvdtCLuQmwqXf6NCX8K3gILYSa6vuUkbZqdmEb/CEE4Z93xlfDU2Y6AMaa6EHRFgySrntR0P2IHl+reF6GdJMsNMD7RQ52GLNUedHmDDIjSVDc9Kybtf87SazpEJoDbxmKN0sSaT4NYc0tJpR+/s86ay9jwgJaKp1LyQaAPRoc7smaY/mhaccqtShUz3+/hlyBkHH0gAsijk9IUmVaSomEhtsSpc5G+yTpWPL4v5NxMebrdEeWxPRg8kFFqvSgFZpxbr+DqXKonDQfDPSc/JXKz8xMbxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxutnPQ/fXVcXPFOm6WArwDNER+V6sF+Gt7vxbeQ8LA=;
 b=X8qS3uIbHcybq8Zc1ChSQDnHYgrCdo7+Pw7ZQLk/tAuUnYeka9dGcjg/UpZdUbHXrFDSqN2RThVnHUthywVLXLV2noI4Eq0DUuGN1rcQ515dKnUn8nsekNq8V9vsHgWCSzu5CSEuZk0CTbxtYmqCnmrkG+PYT3zaqXwstZ0vse2lL3/gqEofDzaPu17c/Y5QLqdLzyIvrmsmL2LD7N1J1+3C9NoUsJyiwGQv3/qgp8Oxj6KvUQU7bf0AYXRgzyoDJKsM/ECuXnanab+bjtDz0eaawbDkX6JHJCSH+0Q4yiemAcnRaZ9x0FPijihyGgsqZg1HGCuPT7txjkaFwSvkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxutnPQ/fXVcXPFOm6WArwDNER+V6sF+Gt7vxbeQ8LA=;
 b=RHvz9liS4+ZdsNFNLuHSRy/c33FDThCOE2JQ2xOSgDd1YbgsdihWHJpwoVp23ckgRXn/x86y7mm9HA8vx5eEZFGiklt4qCdMZLoY/71xyRRP81aHuNMn5ru3YCO0rTOz9hftROdJwYep5UTsseADfpUYESYWfYiBn2KiX/uFpww=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 11:46:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 11:46:31 +0000
Message-ID: <58997574-3333-4ddd-aa37-3b177f19c0e0@oracle.com>
Date: Thu, 28 Mar 2024 19:46:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] btrfs: add helper to kill background process
 running _btrfs_stress_remount_compress
From: Anand Jain <anand.jain@oracle.com>
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
 <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
 <9383298f-a74b-4e2e-8f62-f1359ae68bc8@oracle.com>
Content-Language: en-US
In-Reply-To: <9383298f-a74b-4e2e-8f62-f1359ae68bc8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eed3373-9adb-4f91-6325-08dc4f1cb5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CfnngpSUwd03G7BspfLYV942HB303ef07Z4irNEOqU4RUAA3FuRabXjVOiCcq2C9TdzWKJNZ5IbietO/PZvCENP4VeVvrNqPP9Lh+Kc+O4aVeYmdnJf6CAsnzgi1367JvfnIxxPRkigJXDTj3+Bdv7DwCue6/BdRq5B4WNRXaoXmeZBv8EBv3POf8Rpb6nkTjNAVrxagW4SNUXGpA/c0Y5zFxg+p8ZftKZLATYkeThw4jbu7q/cW7e0XvjjLVzebuEG4D/KrevHWRTZeGSGw0NfDxeuN8vzeyB7x2MKjg7IvyZY6K/Hp0IO+ZvoKGYZ0xHg/i41iwnFteLF91AbAF/JIYiOjvffH1fpPSuqYpoxYW38EH8PhgGsKODHVfT/4izX20fukkpc+SnT1ExaGanzU2/jeXKx780eDGMqWm+hLhXj3aSpnfRdenijbRIk5BCcMN4tZEkP5lzx99ZHR3cImhkAXHHrlXFENj6PBEIczZzWg2UAZlQbFxZ8yDenckBisuAVNsx0YUwvtr4sGSQTS1/Z3VitlR53VtRBl95gULuDY4+Iy9dGmuWbb6NEXPpJPy65VmaDbZwFrWt4VBMSbDmlSGYxXCU7qXscrzC5bqWoi6Ag5mPAmPtTg7zFl98EjIsQriJnF3k2QOuNiQCfvWgF23iC4mNHUxjKEk6I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODVIamJyUFN1ZzJ5RjdrWHludnZySldkTDFSaWU2ck9xaVh6NzlIZmNPTjNL?=
 =?utf-8?B?WXFsby9ic0QzM1NRNjJRcW1kZUtZYURhbW5aODd6MXRJb0dWRzJMVjJIeGho?=
 =?utf-8?B?MTNlV1dyRVNvdFNwUmk1VGhpSnFXWVk5NXMxVzV3UHRrZ0RqSVBOMWsydWFi?=
 =?utf-8?B?MVVpQVF3SFdiNlZWTy91OTNxWWNadHptUks3MytONXlSS2t2bE1tVExYWGYw?=
 =?utf-8?B?b2NqU0F1ZERTdkJML2VVNWdFSmNiS0hFZWtTQ2tZOFNzMEVqbE9QMVM0Mklv?=
 =?utf-8?B?MERNY203QkZyZ3F3RzhPM3Z2ZUpsRXBYaDM1bGN6cUp6cGZldThET1ZncTJ4?=
 =?utf-8?B?UnZCTDVxbUtWM1FlcVQwUGtIY254UlkrU1NyOG9nYStMcERKRTd5RHlYRHF1?=
 =?utf-8?B?V0hmajZoekRnVTZCWUNXWmxoMjkvRGpSazlNUFFDYXQ3VXZUb09uR0JWa3Qz?=
 =?utf-8?B?MlFQQnFpMjNCbE1aTWl5VUNuR0Q0Qi9jTDlhUURzaFFvcjZic0hzZ0xPdmc2?=
 =?utf-8?B?VGxSeExjdzNuay8vNmQvWTQ5K1lDeithOThWKzRLcWZmWTYrcW90TnlsaVhT?=
 =?utf-8?B?MXBXbzZHZitWUVR3NTV4Vm9qb1UzU3ViWFBqbkxzQTgyUW1TNjNnNWVZRi9F?=
 =?utf-8?B?NGkrN2NwN2F3dndPZnJlL1ZqbGhDK0RoYmV3NVpjVHQ5OVZ5TUxOdXd6K3gx?=
 =?utf-8?B?UmNib3FmcUVRWnlhR2J5akZYUmpDNkg3UVFRYk0rOWNBRVRMdklCSDVyUjV0?=
 =?utf-8?B?b1F4N25lRkQzR1ZaTThLOFJoSXRoSGpRYkpnQnliMG82R095ejJ6TXRVWDFJ?=
 =?utf-8?B?dkZFVk5uY0RUdXE3SzNFRFduNzQ4MktabW9sR21tbkN4R0ZkUFpGYnRBdElD?=
 =?utf-8?B?ZzZXQ2I1aHRma29kRlI3c0JSNzhmaGUxeVQxODVoSSs4RXVibDIwTGhUMG9R?=
 =?utf-8?B?Z0doQlNNWHRYUUU0MTdmam5ISGhoUElWZ0psNWJ0Y2dSZWtSQkhBR3g0RjdV?=
 =?utf-8?B?SnZxN2dDVVlLUzVxTHV3VWhndlZxUTNKMEIwSFUxWHBOWmlUMmc0TTArWmJN?=
 =?utf-8?B?V0JQNm5iUW9uV0ZvRE5TUFRnekk2UTlhaHE2RmNnUHA3OG5zcllmRk1EUnRW?=
 =?utf-8?B?Rk5vSlZ3L0xOU3NTNTN3M2h6MjZLMmppeWJZUjVteVRMSnBRMEFVSU5hekNs?=
 =?utf-8?B?enkvZGpWZ0xPVENRVDJXMjRKM1VPVkxQeDl5bGJWTTF5Y0l6QWk5Wk5OTXRC?=
 =?utf-8?B?bXV4NmFXTStFcjBNRGlvR0FpREFUVTA2dGk5UkdsVGJ0NllSRklLbUJQcks0?=
 =?utf-8?B?OWhsTDVyZnNVZUNYMVRPUHlsVEQ4ZllNTGs0OUtYWHdick5Va0ZPYUZIb2Vo?=
 =?utf-8?B?cE8wUTlNY2FsVGdLQ3o4NXROREZ2TnhudDNVMXE4dzcyWEVaTGJkYUx1VnRt?=
 =?utf-8?B?Yk1uR3h4UlRRRDM4T29pOUtmaUtoblByZXhWQWtWdDdaODJvYjB3MkxLbjJw?=
 =?utf-8?B?elZRMXlNYTNDd3E0V3c4dzFDQ2tDbExjb1o1UWhURjJPcXhZUFdHRm1VUDF4?=
 =?utf-8?B?Nk5RRG1DOXJsdFlibXBUSmMrLzYwZGc2MGVVdzNGWi9KMVI5dXpvZE1ka1dt?=
 =?utf-8?B?Qm1MTGY1bG1VK1YrUm1VN0pNMS9xeHVhL1hNaS93RVE5ajdMTnhYYlVTSWhw?=
 =?utf-8?B?NmQrcTladDJtZHVOV282Wm8xSnNyZndqYkZzNlRvTFh5ZG5pMUZyTys0VC9h?=
 =?utf-8?B?NmQxTCtmSnlYQ2VuRFRjYVRURVRQNFdsb2lPNWFORGVCU0VYWHdONzA5U0k1?=
 =?utf-8?B?dHhGQytYbXNtaXZTUi84aTdFYWdTTWZ2cFQvMWd6eExlNTltZHFXeXlQY094?=
 =?utf-8?B?SzZ6aVZtLzB3S1ROYkdLaDRmbmViOXhRa05Pd2dmMTZ1WWZlQlpBaEw3dUJw?=
 =?utf-8?B?aWQ3OGtDZDFmeVZrMmNUOWRucDBhaG05Qld4aVBpZDd0TWVhRmljazJlbldG?=
 =?utf-8?B?Z09OWVdSUlY4VmRBOURyc2ZLNXorbjBldWFVcEhFR0Z1TUZGUjJoZjFvdzAz?=
 =?utf-8?B?ajNjSVpjdFFIV2F2djZlRE5WaTlGRXBVbWFoUjlmQ2dpSE9BR2lKNU51YklR?=
 =?utf-8?B?L0dmcXZCQXlkZmljUlZ2SWJDNXA0aFQ1UW04c2c3ZWY2U01JaWsvNG01WElE?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h+3p+QearLA8y5fywGkGIBR9dPe09oUj3sc76Clevo4+1IxY8Nf9Navoxs4s95xsEPWu60mfIRZQG/jsYxLs8RKHo/7FjR08SjlXB5Efw0B4uK0EQBsYHbn4T59zjL6IdfTv1af2gNQn5ihmRpNISVdmfQJKWn90kAAnF0XE2/GAVRKyIMIici6lGOYzD3J21GDFEQxs6isTLgxAlhdMy9hRjjX1lmaoPW6Pb8q8/WoARediovXGviDR4L3Umqj09mcf9beQePscGXWI4QFcd8swE1/F9dkVh2u3a7HnXssqyjyFpFQ47bGgsyG1Fq+gWktKYpicwCBhuVYF+b0D+rvBIUF8zio78tdEiUjkj72HWSy8v8IsSL8KvUMJ6ePnH3e82BLHnp8ctVXKxj3IPN76o/RF3KzvjYXTmyNhf7vwCcmFJIzglkXhr+AaLZXW/KWEd5jKo5bTFBZRVbpnfsrIJm4afXuhpltRx4mNoW0x8bi8G6SrcFk50c/ehxMcIC57D8FP6Mc27xNvMubCKBR1m6AERPlAaoDK881nye/3+nhqtJVia+EIsk8QXmQIncCsLCUHBANcxP1wMxJGBDoiTVIrxFQbVBaNX463CEs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed3373-9adb-4f91-6325-08dc4f1cb5d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 11:46:31.1445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2n8z7CfetK+FtHJh0y8sBMaYG2gio0wiWdhUThEHVs9gAy0ZU3YX+PRvpymupHqy12OqbrQKw942/kHEX1FhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_11,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403280079
X-Proofpoint-GUID: u7yDda81U2xKZaVmALAF3PkkDDAg2ZA8
X-Proofpoint-ORIG-GUID: u7yDda81U2xKZaVmALAF3PkkDDAg2ZA8


>> diff --git a/tests/btrfs/071 b/tests/btrfs/071
>> index 6ebbd8cc..7ba15390 100755
>> --- a/tests/btrfs/071
>> +++ b/tests/btrfs/071
>> @@ -58,17 +58,15 @@ run_test()
>>       echo "$remount_pid" >>$seqres.full



>>       echo "Wait for fsstress to exit and kill all background workers" 
>> >>$seqres.full
>> -    wait $fsstress_pid
>> -    kill $replace_pid $remount_pid
>> -    wait
>> +    kill $replace_pid
>> +    wait $fsstress_pid $replace_pid

The change first kills the replace and then wait for fsstress. Was this
intentional?

This patch is causing a regression. The replace never gets killed, as
the echo-comment specifically states to wait for fsstress and then kill
the replace. Following it fixes the issue.

Which the patch 7/10 reversed the order to fix. But why?

Thanks, Anand


>> -    # wait for the remount and replace operations to finish
>> +    # wait for the replace operationss to finish




>>       while ps aux | grep "replace start" | grep -qv grep; do
>>           sleep 1
>>       done
>> -    while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
>> -        sleep 1
>> -    done
>> +
>> +    _btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
>>       echo "Scrub the filesystem" >>$seqres.full
>>       $BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1

