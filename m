Return-Path: <linux-btrfs+bounces-2851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321C986ABAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DE91F255EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Feb 2024 09:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B936132;
	Wed, 28 Feb 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hJ1f2r3V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LTqFZ/5L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BD32C6C;
	Wed, 28 Feb 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709113981; cv=fail; b=UCgjrBcH/mxN/0A5PoJsJumOoMGyGyao+7ehbzNxhe78BuW58D2oAJNT855/9Ad13Fp0e4kEg1w9Okp0rQB0Az7OLLk7UU1+N3wd8oVhYqbcw5eNioZHorJdsjNWd7H5j/CD3a6yO7xY5Mdos2s6Q1rlLFE8lJU9OX9UHQykdQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709113981; c=relaxed/simple;
	bh=79sjGBS9k4uFCT24HE0P6C3pfW9b0CiUUfIRrRrZevo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uzNNdA43L1E3yvJKWhC5c4UB9EwCqRVz8cWACgy56v7ql8XF3X6z3HVTyxrX1xR+cEs1iUzCQTx/cBbeEbUKeVHl9QRxIRY12CsB0zlr62aQqFtu7BPNGJoBfKT18021SGt6QsCc6oPj7V8IwpAHATKRTXOsBAuZszHwWd7aTHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hJ1f2r3V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LTqFZ/5L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41S6kCMg017456;
	Wed, 28 Feb 2024 09:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BAZQAiYqfcpFwlmgem9941Npcwp4Qin66LdCNoFziqo=;
 b=hJ1f2r3Vx2Xk/In/zhdnUc8hwiPLcE5/4hGjE/1sYVmqMsgKcCEhfX12hro/TMOakO00
 EtNpZLKZyZUQMJZylpTTavBTRkVPp4X59jRXz4OH1HAi9gU44avNocbIUY0UVeATQ95r
 69pmHnSJ1pacW3rnYRXVOGfzX2nRzXNyUH8TEBQex4cdQ3lD2EOX2WX7qrBFWcY0QACf
 Bc0t6SQ8ZpAkD52N+8uGzqIei+gW9/5Vc/I7kdoFDS0HcbYUkmeTPx1IRh7ssfLhli+S
 t6BuvaXvrLbBzD2x9TdnIvDu7qD64ts18JuAdzEJOpMFCRMNa1333Q+zBj9VE15Jm9BK 9w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cchv93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:52:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41S8s1h0019404;
	Wed, 28 Feb 2024 09:52:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdmg0cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 09:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzKMfFBxChb68CO3nA3BrGlz2n23eWk4YrmLtVD6i3yFMTBMhbK8VH18Vw+hUOpdSjU/SflWf0MU3SkouME+18vEjImeN0vWfYqf8gT1ZSrBNeFXfzZyHWpw+89MCAgGhFjCJxh+wY9pvDEdAIojXxTJNfNsMEUBqmzUxjsuq2yRJwT4R7KP/5ZM8F57fAavPEOn7M43gLlNQ6OYm85hOZvh4UJb7MmQsbPZrszCsCPG/+6GaWf/ry1+PwwR9XdUd+E3FRzq6LBb8wd/2i1Bg5+rZfYTkN2+Pn6iwzrwqDiY3ZJRSDye1oDvFHlR53L2NTrDgVzIAhagKJcuItwEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAZQAiYqfcpFwlmgem9941Npcwp4Qin66LdCNoFziqo=;
 b=nTZ1WUmQe9TeuZDDy34Cu4kGyMVU9kvz+EekOIdHl3WRTAJ06HUdnkp00rttxmhNGUY9EeTHXEPj5tvMitC6i4sgtW3Xs2Sw5QNU8R3GALPeNFCAn0ZwCjFhQZpQJhSq1Ks/qk5NzXo8mNGY8L91UZ2CXx0tZKMG7oRXvnOBXZ5RP5CuQZfXGrTD7YDvHd4i/wcGax6Lj9MB3JI5H3u0dyrSiUgGrs1En14C0HUX32RhDLo0N6bwcGBMefJI8rIDKU0xe3w6pqqw5KIp8rlACgyZXChk2Hfmko43rPK7xDluko6Jq7Nxo5xkPiI0/ADlG9iiCWTihxcXZ79YVCuwtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAZQAiYqfcpFwlmgem9941Npcwp4Qin66LdCNoFziqo=;
 b=LTqFZ/5LDX1GbPFtxUU+6LnnS/cRqA1eVocsR43V4NWF5/kW4eLUfcdzXzyrmY9wdiVkVy+4oqYeXRO8SyKBTmBDmHP7Gypvpe7sFHqgaRxvCcqBthRkNxcAoDLLRrCMfgwXxpffPg5d0GO1NsZzj4G7A/MSLNKLp3wA+1z+mVg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB6690.namprd10.prod.outlook.com (2603:10b6:610:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 09:52:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 09:52:51 +0000
Message-ID: <1c05fac2-006d-4518-9eb3-4ed8e2f4f905@oracle.com>
Date: Wed, 28 Feb 2024 15:22:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] fstests: btrfs: check conversion of zoned
 fileystems
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Zorro Lang <zlang@redhat.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>
 <20240227131223.ghlqtl5oyylhs6ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <c56b927a-8ea7-4406-a5c9-12a61471c91f@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c56b927a-8ea7-4406-a5c9-12a61471c91f@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d12d65-9d27-42ea-54e8-08dc3843072d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Trbl+ZBsq89SKmc2N1OgKbfS0sdhEvYhTbl2XlpKh3qoINSg7nUmxwZ3Lnl3p0BGn1dVlSMRJ3TazmpB3ecuYlalXBEXUXbYWkIcuMMAXkr64+olbxDljC0nJHBcy7kk/Y89qCZHpNSyx7/OlkR0L0UwUyBR/ji6P+inzuSOM7nTzZq6RnSlOLWQIqkAV3oYZdPSLQ86V7IxGBOUJEIXGk0qqDlFYJFOlS3YiBO3m/cSc0XZTurZ/UGch+P0mAzBujOeApoMFIusQY1Dy35aaKbu5COg/Am0InEzGacG+/r6uJl8VHtN+jmlBx5PLFwkK63vCAN49976pJ9kDbP+XRJVqukvdIHOZSyy0ysLc/jocSPR8YkYonKNziqV9bGGkZA0yF7KG2Pf4KDNz1FTgMr23qUpJvnLxi1epOht+8yJJBBqWsSz8fbDpls6kYlR4XaJrZto7XBYvIayAGJMTk/kXUH6qv/5uIY+3jk0AGGPIMFzOoTiCmNTv9KN5RgG3uavPyRr36c/ln4yP3dCOu2foBwKoJKQszuJyHuO/x8Spcuk9yerreov6aQNL7xGZM6mNecCnsTdKCEqN78UBbmgiTZXuCSLN1rTWcNWdxeRPK35i8COe5A03hkpyQu/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVRBUFZMVDhoVlJBelJyTmJhRDJUbHVySk0rQjh2cGFjTkJqMVZYTm9GVGhx?=
 =?utf-8?B?OXE0bFFKdlNGS2NKOTVaSENFdVkybGhFL2xuVE9hVVFINE13OEdrQmRhcUZH?=
 =?utf-8?B?RFRadDZEWC9BVllpOERydk5yNld1cE5MeXZ2SWUyeWEwN3pXbXY5Slc4WWV2?=
 =?utf-8?B?eVFmZm9hemVBR216OWgyNFJJMENzd2ZJUWhxQW45QUpFQVRHcnd0SFlJdjNi?=
 =?utf-8?B?TmpYeXdBUmJzS3BVTHgwNEpGZDM3b25iOVdISUJHaWVPaVNRTmNNYUNhb2FU?=
 =?utf-8?B?ZklhSTRuanhDU0duSU83b0tXL2NFRmVGRlJRUGRBcDErSUdKNWhOc2lLZzRU?=
 =?utf-8?B?RHVxd053ZEJheFBRVE1GVUtjTGxqTWhidC9pWWgzOGpzQlh3Q0VjMUt4eE52?=
 =?utf-8?B?UW1HSTg0Y21IRlRKU3YwOGN0L0VuZ29SR2Q2ZFRqS2dZNmFWSXRlM1ZDTUJ1?=
 =?utf-8?B?Z2RrdDNaTGhZMFBSdlp4VXFTcy9hbWVBQW50LzNUZlFTRmVJNXVQbWwwVHRG?=
 =?utf-8?B?KzcvMVhUckNrVnRrMU4yUS9ZK0pIQXNqSGgrSTFWVDFDM2lzWCtpY1FraDg1?=
 =?utf-8?B?RmhBaU5NMEc4S3k1ZWI5VW1QUlZyM2tYSHBLRVQ3bWtQVE9lNnNQaHllVXA3?=
 =?utf-8?B?ellqRXdmUVFwc1NFYXNVR1E4TWtLMVJFbHVjVWMwd01adEJOQ05tbFh0UUpP?=
 =?utf-8?B?OFdQYW9iZnhmOWEyWnBwdkZ3dy9wUXpCOTVWeUw4V3F1TmRRRkFSdG9zUXZv?=
 =?utf-8?B?Rnkyck1tcUNFZWJFV1psVFZuNlVnb1RrZzBFSjkvRUFaREtYeW5TRTBRSEpo?=
 =?utf-8?B?RnduZmlaTDlsYTdHWWF6YXQ0Mmkyb2JDTUFtNjY5NXBhZHhKaHhlOEpmN0RF?=
 =?utf-8?B?dGFMb2w0K3F5eWpFcGk3Zy9nZjBuaUZHRytLRzRYTWtuR3FpNCthbTdId2kr?=
 =?utf-8?B?ZHBuYjNkRU5ReWJLb2dweHRvWWQxc1dlb3EwZXI3NERIc25hQU5SR29mWGNN?=
 =?utf-8?B?dklwQVFxSlpBRnFzWHhNWnJWWmE1QUlPMHFFdWg0NUhoM0JSZW9Oa2dqSmEv?=
 =?utf-8?B?aExIaTUvZENVUjQ2NSt5SEQyclQ4TjlDdWNBdUhNTE5ISGVpZkZoMW5vSnFJ?=
 =?utf-8?B?MkY5V1FKTTViUkpnaTBtT2RpaXlhVUhDalJPQUVRRWRkZ1JrUHFQcWhWRHNC?=
 =?utf-8?B?VmttaGFHUVkzRjdLMFpodWNGM0FDQnduZUtoTlhZR1FkTEhKYWNacm1XSzI4?=
 =?utf-8?B?QitXZ3dsaEd4aG1XV0ZZZmZ4WHZJZW5xd3hkTDZtREFCdzk5ZUgrMnpwS1hD?=
 =?utf-8?B?eEtTMWtWUjUvNXp4SGx3MEl0ZDZNZG1Eblo4T25uZnlIeEU3blNLalR6bGp5?=
 =?utf-8?B?V2dmUmJHWS90ZmVpTjdDMy8vV0Q4VWJ5cFc3dWxNTWRSZzdGVWhXK0FkZkpx?=
 =?utf-8?B?RGx0UlZTR2s4ODBuRmx0UjJPMW1rTG5VMG11Wjl6Zy9TRVQ2Q1FzUmN5VUx0?=
 =?utf-8?B?TUlqOFMxSGdlWUtqRmdRWDVYWkk4VTJhRWhxSjJLSFNJRzVpVUc3ejUrUC9v?=
 =?utf-8?B?UVdQZXZvNEZLMjVwN0N4Y01KMTE3TmtzQTVPaUo2anhjWW1XZmFYSCtFN015?=
 =?utf-8?B?ajZ5MnpHM25RRURqUmJqT2hjc1g4TUNGdjdqNmo3ZFBaeG9Jak9kU3B0UER6?=
 =?utf-8?B?UmtnWHVsT1pZd2tOWGRBOGU1VW5ZaFlUcXVONkkyZ0lPdXVHNjdaMjlIYTRv?=
 =?utf-8?B?WWRqWDE5L1JoKzBnaktMdTBnSVdBUlN5MHBDRVVKWDdqOHg4bDdndnVybUhz?=
 =?utf-8?B?U1NRbnd0WDlwckNkZTV3dXZVZlhzclFxUmwvSmxzT0NQRTViajRxenVVSmNI?=
 =?utf-8?B?ZzBRK1lScjkyNjRNZXQySjd2WGhhVHB0S0huV01UTHlxWnlERGlBSTFORUZz?=
 =?utf-8?B?MytZYVptM05FV25zejJPeUtVSDdPbEVkNXZzb01GLzcvTG9Wa1lnLzVPSXNK?=
 =?utf-8?B?dlRueno5M0M1MEs0VGpuNGNPYkl5UXZRL0lFSWZubGRMcUx0Z3MwR3FUaDVu?=
 =?utf-8?B?MHJuS1BmZUxtcmQwUGw2UVkvRmU0ckwvMnMvM3Z4MXBQam80eEdvbVJEZDA5?=
 =?utf-8?Q?aTQEBJ5OpOoF7Bb72Y29wuMo5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vyLBgEaqDT3jMNQAE8YAeP+V0Onhgu5SGlYM2j4QFR07t/ZGg5KG+xclUkeKiSmu5ROqUOdCuspaYdXE53BnVmxhty/72GC4pCynIVHATx21d03RtUi56ndIxvbtCiaiq5qe0ER2q4hXeZkgBUVTDChKY5UnrGI8mbMrRZ6zsGerOMwZ68RzsNgVm8X19M2SubhJB6Bj65OnHwA9OPY8KtUxv7WV6lnOEjFms6i2v396bAVcWZ6Y9zfqmpHEpRrTmCrH0hGADAhMefDKjYwi3gnnBRPtlt3ERUoyS1mALENqppyVqtJKKDHfef8GWOT8QJb3TcvK4T59872vpR4FsSimAe1NQPoDcrlgS0LNLa9MXPMglxii8jQHgjLT7LLTgYJxya2xxpsSn9Zu2lovMIQnHL/Wajhn0AJps0Qk1XtNDMMRtD1J3JRw45GSZNU53r0QSS3pn2LwYti5IsAJ+NxLKGtyRGBEmfTYppM22q/ScMTLzRew0OY6Eu/wR0UmcRHGdTeBsVrcF6SGaf+T/tEjYACFNr0Jofa+e1LZg3RfiWl7n0mg9d/mvXPxTa46PqGt0V63oLZwe+JtfPy+Kd7zL+n4f9wBSL+3bFDMvNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d12d65-9d27-42ea-54e8-08dc3843072d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 09:52:51.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrEpNnkm/Gt4X2u0ubxA5AdMvHt0TqW1cmC1MBpw7K7/7UF0h48Xf1NQ7E3jSgk5mUh0G21dmJFSJQsCrhqqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280077
X-Proofpoint-ORIG-GUID: 53XEYYS8tdqMPSpuTpi-3kSqG0M-iXhQ
X-Proofpoint-GUID: 53XEYYS8tdqMPSpuTpi-3kSqG0M-iXhQ

On 2/27/24 23:04, Johannes Thumshirn wrote:
> On 27.02.24 14:12, Zorro Lang wrote:
>> On Thu, Feb 15, 2024 at 03:47:06AM -0800, Johannes Thumshirn wrote:
>>> Recently we had a bug where a zoned filesystem could be converted to a
>>> higher data redundancy profile than supported.
>>>
>>> Add a test-case to check the conversion on zoned filesystems.
>>>
>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>    tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    tests/btrfs/310.out | 12 ++++++++++
>>>    2 files changed, 79 insertions(+)
>>>
>>> diff --git a/tests/btrfs/310 b/tests/btrfs/310
>>> new file mode 100755
>>> index 000000000000..c39f60168f8a
>>> --- /dev/null
>>> +++ b/tests/btrfs/310
>>> @@ -0,0 +1,67 @@
>>> +#! /bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
>>> +#
>>> +# FS QA Test 310
>>> +#
>>> +# Test that btrfs convert can ony be run to convert to supported profiles on a
>>> +# zoned filesystem
>>> +#
>>> +. ./common/preamble
>>> +_begin_fstest volume raid convert
>>
>> Don't you want to add it in "auto" group, to be a default test?
> 
> Actually I do and forgot about it, sorry.
> 

I missed it too. I'll add it before the PR. I've updated the
mkfs as Zorro suggests.


----------
<snap>

+_begin_fstest auto volume raid convert

<snap>

+_scratch_mkfs -msingle -dsingle 2>&1 >> $seqres.full || _fail "mkfs failed"

<snap>
----------

Thanks, Anand



