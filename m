Return-Path: <linux-btrfs+bounces-4015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBE189B6E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 06:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFE2281B45
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 04:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0963AE;
	Mon,  8 Apr 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jngfmdzz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HbYuGXRN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C72F36;
	Mon,  8 Apr 2024 04:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550630; cv=fail; b=TwHsRlZyAG9hnqRonxXaJbQQ2T7l7rl1NoUzSTOaz1JL7+/h6gpHJVT79c3KF3QL5xXg7tYCaZLXRYRRAzWfQ3Mx/vwZtBBQdLRqdkBoyl4q/OBZVWdaPQs8UUiAG1ujJ0neBVJFiZPzkHgCSfWA7GySGoIgZjonLd1xHgllV5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550630; c=relaxed/simple;
	bh=SzOAJ8G01q698q0n/EAc9iA7yNIbpfJd6E16TUjPzFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dy1YAiGy9FUf6vVb9qmDAKJgRF/OZUuQo1T22cXCVisKopmGQaGWPeJ0rbCYpzoqaDuxddwc73NTQ6kQAPhczAeY3qmrEteoe0j43ELFyfHmBkVeLeHE4JvRjmrPj2RmEBZap88DbEYbba0wvTbenI0+SRwkzZnrNSmwChtO1fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jngfmdzz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HbYuGXRN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4380iAP4011211;
	Mon, 8 Apr 2024 04:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HGdOphyikd69D7fM0BfXTlUetLGmWpGyqzZPCopq1+w=;
 b=jngfmdzz2VS+SST2uINkzd/LGvVyuASFt1LBWc3tHEaiPqP3o5+Zvou8mJHZsrYJSXuZ
 o7JuHA/NRUoOxpmQRlMEQsCxRMSNA0aOAumA8m9DcjehSlCy+ygpX5eq/KJH6HIUN3dc
 lG6PQaNsvd+ou+7W0b13IOo2lEps550YPc4h4uNKgB8beMwqLCXIPkuAVCenJKX8VZcf
 n1vxOfutdyZe+MLkygjE2/9fle6wKrZ2nH+pNVnS/pMSS3fOLh4g0xxtRC0eHiKYAMzc
 XMOcFE3rBJkAh6nO3dAWD7rGNyCt09yyuLYjmTAx74oVyfTEimD43eOSB5cpiOTQfrvD lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0uhnvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:30:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43835SnI020069;
	Mon, 8 Apr 2024 04:30:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuaxskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 04:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWSYXhpp/oybVIF5yv3RcNBugojCMj1PNsSuJHyd1tEG6vA5WJb0gPUcZS2h3RbowM2q+EhtPQScCHn7ji9i8dxZ3B5ObAXrRmkSbdsfch4buNhCiAyrTl//pNBR/11W6EihA2pwiw7uspwjNBBMmQ91g3m6EaSFrLl1LUC9UUv5IZm9vz5eeVuF0vs/GbSKa36ngQaIawWUHyhWdgZB8WSoo2maa+4cSoQrWduFotemQbfAJQvNvRjYFIxpftkM9mUU4OFbRAxVzn0y9QN29OsMD5ssSajBZsRiJJ80p3OvV/sHKQw2OOUmCQATkM39PO3JeuKOJn6QHQgaP1/R9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGdOphyikd69D7fM0BfXTlUetLGmWpGyqzZPCopq1+w=;
 b=bQJJUwcZUZS0lHS3WP4h0PwtQwJ+0TV92r8EO2FBv9MT1zgzYkuYSo3IoFh2hQ8YLe0eHSsV2AkEo/d5naaJ+Hcft87SanwKyQr7eHfZg3X/54F9TFSxMeneU4rBE3Mfor9Y/0QnhIZ8JsnRJrqrjNiqUUofXAvk464gPp617QbJndVRFiuuAM08ElFgbUix9vVfvllVUt6nzovf32VS2r5YNbNRSTjnDf4cljRK60gQgybOdq2TEjeOXizHvtWIDLCwI4FChIQ6s4lSn0QChVs1JrmEUC8yP9kuvG6KHU/wiotbEZtLnXmht8SB546aq2NwvvKoX9QQUAm6+74Eag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGdOphyikd69D7fM0BfXTlUetLGmWpGyqzZPCopq1+w=;
 b=HbYuGXRNoPSJegtvWdiQc7x0n7PeMq9e1TIu59SHY3mU3E/TnqmCtIJR0JpeeNcygN//j1/qR37tFq2mv7NgbcbisI4RBEt3gOwvaxTCTjl83yBUTpUO9e1grIjf7EHpG6yO/TkQp2vdFW1rSdNww2y6WJb3MrkzpvyZf2TN56s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 04:30:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 04:30:12 +0000
Message-ID: <ff028a10-747e-466f-980c-db25c1194d6c@oracle.com>
Date: Mon, 8 Apr 2024 12:30:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: btrfs: subvolume snapshot fix golden output
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.cz
References: <cover.1712306454.git.anand.jain@oracle.com>
 <a4ec0dcf-677a-4f84-aebe-851203ae0f4a@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <a4ec0dcf-677a-4f84-aebe-851203ae0f4a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:990:59::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V2QqGA6cwhBXt9nIwBrb2LoEbqY+e/Hmsio4n7BRcv1ANfm/MOnI1YyhuwYAwJ0Fz8A0/iaVSTiFGtEHVp4+BWmCNu8xKeIXLrDDa0n9SDbsnhU7yOi3WkJMdqKHnn9okJ1uTADYEmuUlH5WIYoVhpiHRsa4gt8VcimMIjTsf+WbZhbyW/51ZIdcHmNHw/TO9Y+KJQNnXCPUVJKzKiQ5pQg+Efc74UdAPhnJsadDHXUhrSqifqO5AInzP/nlhGa78JS8aqJ8IUtZljzlvrho1KpxLBFD3rxrSjRCpZPrxCcqfcLjYD4IFrTfnjAwEMNfDjuKAJE126+leKeEmg3eoqMRbGdtKqDJBNeTK62jWQRWlroPPzzlKg75uXT4AA4UNOr4BsvtkQpC5IHxmzVZ7jWSN+o9aUlUxx68C/ErHyNT7IwfJHM/cF/NR+DiVmugctKYQgbtVADovG/mZzZwZbiw9nDjazUX6hY46Q54Sqt1y1BBTIJMi5yIpQNimmAQoUP2NGR9lmyRh6r1S7gv2fiYLmph7Ik1m1Hu+FiDaUeWi4ncOEmOkLZO6GNhJGJ11oEtp+Ewu7Pk+5Yhbdd68hcsYGYfZm7KJok+0F0DeEZt5QFbIDYr3jlAEPGJEbFPOjdUF96xAhFRX+aVecWVANn2AbryD4mDXx+xThHRdTE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXkrOWhYSXFBMTFRcHJtY3BSVGpHcU5VbCtrZUkzY3hWUU83dlpPL2lnK2FK?=
 =?utf-8?B?dzVDRWJycFh3Z0ZRZXpyMHpyWDlMQ1BqNWNyRDB0VHZrOEdvS3hXdmdERHM2?=
 =?utf-8?B?NWlLK0xMZS95Sk1BNVpVSzkwNUgvL1pZbkowNUsvVlNVNU1kMzBrNVczTUd3?=
 =?utf-8?B?VUNGSmtjVWV3c2pCTXk4K09FeXhscDd5UGNaWkdrYnM1ZnBFSzRlSHhNSG1h?=
 =?utf-8?B?VzV1eFJUL0Q2c1VtZzQ1OTFiMWZFenRJWWt0dC96d09rTTM0SEM4L2o1WUZC?=
 =?utf-8?B?R3BKUHd0d3NneGFCRXNZczl6d1RXczJMcllUeFlyMjY5ZzQvWXZFQ21zYUV0?=
 =?utf-8?B?UWF2WEVvY0tHR1FrOThrWWNaT2o4aVdIYWh3QlQ0Z04xNmNZc1NsekMvV3lB?=
 =?utf-8?B?d0V0dVd2b203a2lwZUp5RkI4aVZiYzEyc2FoUnBRcVF5NVBVM0ZHbmlaWmkw?=
 =?utf-8?B?WWlZZ3JLaG13Wk5weVlKQ3dGUHJ4aVZEUDNCd0tmQnVOa1djcklVYW9PMVV2?=
 =?utf-8?B?L2RGbkhLWnVMNFlXd253bWh4NzFDKy9mK1pEUGNaUVV6dnhoZHFSWWtPeGxo?=
 =?utf-8?B?TlozYXl4WXV0LzVnajB6WUtxcWxmZGhxWDFrT3ZHTHBkam5iMWZkeVhoWDY4?=
 =?utf-8?B?RG81Z3ltNmRIcjZZeitiTWlkblJ0M3pwOEhycDBndjU1SjFtWThMNmtUblgr?=
 =?utf-8?B?WU5TSDJNVmVFV2lrbmpGNFV1SytlMTNQaHoxeURVR1lNdVY5WjBhRnE0QnRz?=
 =?utf-8?B?dytZUERCdTQ0RmNiL3B0eDlJTytwMGtMUWxGbUZmV0dwNTFnRWxFQnp5cllo?=
 =?utf-8?B?MDBuU3I3clpzN0lGYW9EVDRiS1JVMVBuck9lOXkrR09HTmZsODAyS3VQQkhM?=
 =?utf-8?B?VTlwTndFMitnMndFb2VlOFNPZ2ErRmhpUmdVb3dzTUtpb29nU3lTcGNqY09M?=
 =?utf-8?B?c2VqWVFCMVluajdkNDVWWFM3bTBKYjJucEI2SXFKa04zRXdlc3NSZ1EvWU5O?=
 =?utf-8?B?LzZpSElWWCtEUnIrMU9ZUDk5TGFpSWd4eVZLaWR3NWZYbG05UzJKMVIrdEUv?=
 =?utf-8?B?WENFZmMyREVuOXVRaTFPV2NWZUE1ZlZrN0lEazA1L2g5MVBiaUd0eVpmQ3M4?=
 =?utf-8?B?MWoyaVVua2sxS3BCY2htK20wME5Oa3ljOVpaSVAyNDlBVXdiTXRCTXhBTnBt?=
 =?utf-8?B?cGFadk5GYXhSYXAvY1d5blhRdzAzM1dQbTBkWEpmZzlCZVJ5TW9acmNhU2Jp?=
 =?utf-8?B?NGZOM3lNN2hJNkxnRmc3OFppRkRESDFYSFRJb2lwQk5tZUtGVXlzc1N6OGli?=
 =?utf-8?B?WTdqd2NnclR5ZmNqblRCbE5ZRWM0UUg4WXBnODM4aTJZR0ZUVlJTcUwwd3dH?=
 =?utf-8?B?b0RqUnhXU0hRZXBIdlJyOUZVR0xqdWV5ckJYb0hybEhzaXAzOHZBNzFxQzRK?=
 =?utf-8?B?VHM5VTlJU0hwUDFZTXpVZjhhSFYvRFh2NHB4SlFlSHZYNkl2S0xrWHYwcDhO?=
 =?utf-8?B?Tk1GMERRMWJYREtvZWhxQlRNZUp1b2NzWHlwanhJbHEwT0gwUVRDME9tMUFT?=
 =?utf-8?B?VFFORDFCT3RJVENGTzVjZXppQ1BiTmNUbXhTOTNNV3ZGWFJUa0Nqb1dXZUdE?=
 =?utf-8?B?QlZSRnhDR0dPMVFsbjhDc20vc0hyKzZ4Rk50bTFzM3A3NVBoRE1qSlRGa2w1?=
 =?utf-8?B?ZmxMM3Z6SnN6YzlhVEdwM0t5czdhc1ZYcWxxdmFCb0tpVmlrRHc0dHl1SEJ0?=
 =?utf-8?B?Sm1XR1JlN2o0M0thQzhORVpJL2hBTmJZODdKbGlsNzFTRFFxVFNwYVV6L2VX?=
 =?utf-8?B?Y3Vnb0k3eXJ1R2xEcCtBS1c5dkpMRnBwMFAwYXZjcnp1UkRMek1QODJMamgz?=
 =?utf-8?B?Z09Ec0FMSThIU0dsY09SeHl3TUJjcHo5bFlWVTVwMk5teUUvVnpPazdOaE9v?=
 =?utf-8?B?ay9NbG9yU1ZzZi9uY2duK3YvNGpMV2tnRG5qQjZiU21KSDhRaUZrWW90VnQ2?=
 =?utf-8?B?QXVUcG1BNStCY0dJQVRJRmxGWDIrbnFRRTZ3U3FBb1gzaXJyS1U1K1NTYnJG?=
 =?utf-8?B?Y3lrOUtSY2xLY2M5bUFoWnFGVHYzVFh2aHhtYitGVG1nNE5hQnZMblBpMEpv?=
 =?utf-8?Q?jLCsRM7/OR3MRcyfcHAehh9PT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ALU9nFZqj0ALn7GScClbe1EjldnTHEQ8QuZ2cywdNMvqu/Y6DKxUHAhsMtSn+A1IA+7VM+jqrwgD6wU8JTEmpil8dnHkHpd/gM2BvSK7a1DmUw7fAngAAvzHdQngP3LSGmc7EZ9ngC0wpfwfMSkrObII6OUtdFb7f5XzwquaEOZPQGV7Vyq/RmPGz93hSd0tnCeYDH9Ur8sdojTFSyg2V7MxfrEzvcfrDtE8555Hd6EAmZUqN3UJUsUxZGIDBO0sBW7SjnJ5Y+3YYie/wwL2ZWNyaRTvoskyqQmt90ZHxK9eoLLmZVmEZ8Qln2h1EeBGaFHwDyFayG5+xVp21KKqhK0Vjbh7TN1/ZYT3bNZdF2aEVofOpCGQJmAJW2MtJlltHxqNagH9CF7fdd9dFL9Pq6NT0pqe0rMunUTxoZgVSgVVkcU+o7S/2nX/WF+UIRbe8cprekKKdUygcfqzWOnXz1gPOeRYL+CsE2G+lHPnenJBkmsKCV9Myp39puXPNRy/ud5vTm6uk/nEvuBUrgobG/reh1tpRGEnxFvDRbmYUgB2uK6ja7RgPJNtHL6J/BvPKqnix30zQRcrDVd31OiosHLbjidr/I/9/f4vrCpJJ8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1ddb1c-2389-4d84-3ef9-08dc5784945c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 04:30:11.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FA8E+5uKNwKgC486U5gzqIunDcgdFiv1rEbCUVD3LuWEVm2vlL5z6geFfUXpDxyuxmGCestnA+Ufz7ock030Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080033
X-Proofpoint-GUID: LTGqgwvAvs1-UChdB1zx1A-R-_1rDowi
X-Proofpoint-ORIG-GUID: LTGqgwvAvs1-UChdB1zx1A-R-_1rDowi

On 4/6/24 06:05, Qu Wenruo wrote:
> 
> 
> 在 2024/4/5 19:15, Anand Jain 写道:
>> Update test cases with the new golden output for the command btrfs
>> subvolume snapshot, further introduce a helper _filter_snapshot() to
>> make it compatible with older btrfs-progs.
> 
> BTW, you're missing quite a lot of other test cases.
> 
> At least there should be around 20 test cases affected.

  Fixed in v2.

Thanks, -Anand


> 
>>
>> Anand Jain (2):
>>    common/filter.btrfs: add a new _filter_snapshot
>>    btrfs: create snapshot fix golden output
>>
>>   common/filter.btrfs | 9 +++++++++
>>   tests/btrfs/001     | 3 ++-
>>   tests/btrfs/001.out | 2 +-
>>   tests/btrfs/152     | 6 +++---
>>   tests/btrfs/152.out | 4 ++--
>>   tests/btrfs/168     | 6 +++---
>>   tests/btrfs/168.out | 4 ++--
>>   tests/btrfs/202     | 4 ++--
>>   tests/btrfs/202.out | 2 +-
>>   tests/btrfs/300.out | 2 +-
>>   tests/btrfs/302     | 4 ++--
>>   tests/btrfs/302.out | 2 +-
>>   12 files changed, 29 insertions(+), 19 deletions(-)
>>


