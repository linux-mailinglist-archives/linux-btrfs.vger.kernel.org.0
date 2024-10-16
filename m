Return-Path: <linux-btrfs+bounces-8974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDB39A10BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 19:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0271A1C21AB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE5B212F10;
	Wed, 16 Oct 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jl2rk/wm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Yz7rHJJ8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F3121263F;
	Wed, 16 Oct 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100146; cv=fail; b=TBMfhaVlf9wntVN6lz61FSzoHO9k8C0pte7pv0KaINtiUXB1bg+alzBZumeavR+APwpnswqJfdXmlVQpK/UZQtj2pc246k2q5LxPQVXYgTksBsdl7RBkQ7HNBIG2hnVgbgFEMZ06XMq4peT+g+WU8iu0IB8jnUSPlokQ4JK6wnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100146; c=relaxed/simple;
	bh=2V63VqIbtATOL2wGP5R1r42wxoFqWzD2RlbgkDfNjwk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TH2va5hIRTKxtGo3IMZtGQkKgHdCj4Y8RFvPH3Rpm5q53dHaxHNwpr35xv3vZKbhkq8j8nXzYs2+TsrC/SoZaiQ2+c8gsyiSjyn4S3rnlRWzjHcNrGDNmqHmpm7YXrunI+3AYuaV/7BW/TjKHSPUCfIr05pPledl0+f6Z7RIQBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jl2rk/wm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Yz7rHJJ8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGBguO017890;
	Wed, 16 Oct 2024 17:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PtjCaZNWYFdYauZniIUwKpP1V4wqK3qSFPNKYe6ntqQ=; b=
	jl2rk/wmna3y+1P4GpY/H6etcSlNDxjb1WqywPdFjIgkIN3qOPvORxAuFFg5SRbm
	lzbZvh1vf1dcAU+pa6nrpYHlib3091efAzXF65MlEgeXuC3ZBKjAGuAbUFrAW9R4
	uxAV0OYwmdop0dIS5As/MHnQEExoTnC/bL6LpmJqvHe9KrqVzj+JHBk0LwbHFSL4
	NbAvzXvrj9+bVxcopLuBjnj1rmNfsTweDW8yi+28Uh4kquKCZxrfk0LUczJ77QKq
	5tpf21CBdJruG8D2/ErfQgYdXuEVk+koxQhhyPi+R7LA/Wtp/jnlgP63MD2lcv94
	aBDVgqvgujo630pOfNLuCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcm1b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:35:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGan2W019884;
	Wed, 16 Oct 2024 17:35:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj95r43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 17:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0Y1CWHn+hw/EAcRCHUB4pZ9rmfmwkgt+tJKCzCgAK6OcKWavChjIwL5CNo/3CJPiRHmWy3h21gTQQniAOYI5FUlVYdEXI5Zvc9mf91VHaoKKgNepMqW2x8Hmg8VihRafeiFlSB6XQT7s0DQVIu9w3JUh+8kaMCIlgO30V5/9p9PK/kiVvcDmuT8YN3TIfBMuXe7viMSr3616Zs7bgWSSFkvaSP3IzwqA5pf+qUnP5Dy5VVfgOF+qNoxSKb1lTfY57w2IrxQT3H5vwRwninBMIegTncDRtLaMpIBKDr3B/u6jhe+1OiC9A348a1QCYTQvYVYf/PBfSfmT6yRCQzhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtjCaZNWYFdYauZniIUwKpP1V4wqK3qSFPNKYe6ntqQ=;
 b=fGPx7YJqrdT0kTx8Zd/D+5Ke/dPyIh+22Zw47jN8YtoZMwnutzRK+r/LTrp/1THWxbhhIzQjoOqlc6X+YNJEjJQIREZTVa1nLs0uUf1cOm+wcJJ8mZUUJouW/sw+qoq4/7At49ieKtdKjSImJDEGM5Oe7vY5KEWILRn+XrD7CN8WRXE+m6+1Qt68ii3iSEz57EB1Tso61ewjPHUU6HG9sMq7o5gvDs1Hqa4Q9IfRr4AuxK+AtT42hwJc5HL+RoGsHB84AW7Al8UrCLEx5/5dF0rM9HM7XHI4kQLGZKv0FFpJEk08FQGFFro9/DO4gI889sl90MibBgbRSQnmIuauww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtjCaZNWYFdYauZniIUwKpP1V4wqK3qSFPNKYe6ntqQ=;
 b=Yz7rHJJ86/sIg1EGTJ8VKMDUpcJVfSIuZGyMXDBQ87dnPHxfObTEHc7lm4HgR61ugpq51FJc1CzaeXEpMHaf8D9iY1l9pH+nOKxPii/InAuDX0n9GCuUGb4iVKstnNW9AGnSZsxFfnHYDVAhLWyX49weVi9+qOC1Hlx76RborbU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4743.namprd10.prod.outlook.com (2603:10b6:510:3e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Wed, 16 Oct
 2024 17:35:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 17:35:35 +0000
Message-ID: <ea728b24-5ffe-465e-a5aa-73a28b04c7c6@oracle.com>
Date: Thu, 17 Oct 2024 01:35:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: add test for cleaner thread under seed-sprout
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, fstests@vger.kernel.org
References: <9925ac0001b867a523a8c9c838536b50c2b19348.1729034727.git.boris@bur.io>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <9925ac0001b867a523a8c9c838536b50c2b19348.1729034727.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: ea64e3be-144f-4356-8d15-08dcee08f0ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djg1Wlp3aTd5RHNnUEN6TnNrNHhWMmpCeVNDR2x5QjJkSy9lbzBiNWMxcWo1?=
 =?utf-8?B?Mkh2SW9lNTJiQmV0YmZwcytEYXlKd1p2NWJ6MGxpaUxQNHpKWnJDNDNRMlli?=
 =?utf-8?B?TWRNUUYrTS9sV0VWQnhtbFlhSEkrL2xTd1lwWXIrT0owWHpvMW9MQXpDT1ox?=
 =?utf-8?B?MWNOc3MrazlwTG1nMmdFZU1tUWIvMlpURXh1YW05cEhDVVlPVFZGTW5mU0tr?=
 =?utf-8?B?Z3dZemRlbklZbTJTVDJ4bThpSkY3Wno0WlBqckYzYXprY0RNaHdXNXQxTkNL?=
 =?utf-8?B?c1ZScnZ3UGtEUmo0VFZFZE5mZEhiVkszRE1Mbml5NGpyenhONlJhSUkzcTAy?=
 =?utf-8?B?dzE3MDJLbHRhcTlDWUNIUFFpSWVyYWp2V3NBUmJ0L3RucENYWDcvWGU3RlFa?=
 =?utf-8?B?U2RUenAva1V5YWloRGVnZWVIaWdRZ0JrNENsTHlJWjI4eUhiVUVna3lidWRF?=
 =?utf-8?B?VFl3d1prZEpvM1NWWStYbGUvekkzNU9JTWJKMU9oc3F2cDN2QXJlUG56MDRy?=
 =?utf-8?B?Wm0wNlBvdEhxZ0ExWm9TRWY3VnVaQ1QxZnFmRzhuTWEyOFUwRklsS2Q2R3lM?=
 =?utf-8?B?RkEvbjkzZDRoQmlLc2dPa3lucFlZbHdKL3lXRFk3ckthT2FDaVVtbUM5Y2dE?=
 =?utf-8?B?cDZHZjhDK2M3R1MzQmJIZnV5cTc3SHJpNnVLckxWL2tYcWFQWDVUeTlDcWdH?=
 =?utf-8?B?SE1kWm1XdmRDMFByLzBwdEFseXlSUnVhdE9QR3VhVmVrRmV3dVV5aU9qT2FG?=
 =?utf-8?B?VmtwNUVLVExwM2lEbkpySnF6bitJOEp3b2krMmZFcnREc1AzYnJ0cUtEV3dO?=
 =?utf-8?B?VGtBdDdCVHJoKzZUTmhGTDVGVU9YL0NkOEZRdnR4dlUvdUJNaXlOVmt4NzJM?=
 =?utf-8?B?dFNLZGY2bGJZcGRVK2RHQWR4aWlDM2JibnZiQTdCRjNRZ3E3bFY1SmZTUlBn?=
 =?utf-8?B?Z2NuQmtUS0tSNDRwYVVWWXhNZzNhTnZ3UW1tRUFEZUx0Q3JMeE9SVytUTjFk?=
 =?utf-8?B?OVo1b1crUmtIT2paaEZKRm0weDVCYWJkQmFNVWNQWFlUOW9BWjR6SDlqcElu?=
 =?utf-8?B?MVNUSW1tL2lLbVFJblg1UEVGbU83d1ZkQ0FobFJzUmREV3VnVXphN3loVVNt?=
 =?utf-8?B?YklEZGZabndzZmROYWpoei9FaUxGSzQxVUdPS3VVd2dGOVlPOXJ4NEpaWTFs?=
 =?utf-8?B?OFpwYUh3K0EyTnZaa0JFV0l2NFBrSStFWmxnbGVxd09XTkRhK255dHNVMDlI?=
 =?utf-8?B?RGkxZVNDTlhEdlNKREFLNkhON29TTnFya09qdGY0Uk1tZjN2aVVNWUVZaTMy?=
 =?utf-8?B?UVR6bmxyY0w0dkJ5clY3WGJzV29JQXVKMTZHTGVZc1lIRGgwQlZKTzlYejht?=
 =?utf-8?B?R3pCTGNXNENhamo1Q3hrUGtXek5WcTQ5WGdsRGdwM29BTHlrb1NMU3MzVjA5?=
 =?utf-8?B?NzFVVDNEUmpESEJubXhiNmc3S09UYy85d2hPVWUrbEJod0J5VTY2czRkdnlZ?=
 =?utf-8?B?bllhOXoxQ0VlemhXWXpOR3N4YXB6SjM1M0VLNlMxM0Y1ZFdNZFg0bXJpUlAv?=
 =?utf-8?B?NVNoZ0ZkYktWTlVTSmMrWG5Jc3prb3l4WnI5azEzeitDUjlMdGttb3VETHJ4?=
 =?utf-8?B?V2hqWHY0QWx5Vm8vWEhOdUNFWmh6cExkS3dLMTMvT2QxTGhZVUh0M1NVcHJ1?=
 =?utf-8?B?d281SXE5aE9LUnVoYnd1N1hnbzhEa2RHY0ZqNEtLQ0hDYnRXUlFYM1p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNpWUlzUVpyRmI3cnRrY1BPaml5dGxKREk5UnVYTGlFbnRjSlRLMW5WYmZr?=
 =?utf-8?B?cmNnYlNaVlhwQVJnajV6bnBsTEUyanhSTnpmWElLWk9MQ0czRVdYKytDQmhP?=
 =?utf-8?B?NjJBajI5Y2pISGoxVVpQU2ZERVpZR243N0dDM2I3K2NkT3JXY0wrZWpuQk5Y?=
 =?utf-8?B?Y1JpRVFGdE5rbElnZVBZUm02RzUvWDlvWmVyY0J3c3gyNHh6SEkrM0ZnYUNo?=
 =?utf-8?B?dnJOYVFDZ1hzUHB6L2txdmhXZUJuMnk2VUl1c043SlFDL3VDWjFkN2xCZEpN?=
 =?utf-8?B?UlJUWmIzVStVRnJFWGRLK0ZjZGErN3JheFltSmlwTlNyQkxFVTJFdTdTbSs4?=
 =?utf-8?B?S3dlRnJ3QTlZL0c3dCt3Z3ZPNWxrWDRySnlFRE5qZ1pFaXRLditFc3BXdVFE?=
 =?utf-8?B?a2RjcFJDbEx6MStnT01uQ1plbzVra1VqQ1FxK3VKTlE3NHNHL0dVSWN1WUNF?=
 =?utf-8?B?c3VueHlqeWxEYk5zR2R2REV3aDBjZlU3U0tuMnRoWHROUWNHcDNMMU5JNE9v?=
 =?utf-8?B?dkdkZXJYMmNrbEpmREtELzJtakx4U3gyUDB1WUVWTDRGWFB4UktBa1p4djU2?=
 =?utf-8?B?UGNCNXBacDFudlRiYjVuTnZzdmdER3dQU2FhNVBDT3hid2JVMm5WVnM5Mm9m?=
 =?utf-8?B?L1JuYVQ0dmVUeUNpeldEcEdnL21ycS9hWCtMbjM4ckdxSlZQdEcwbHUxNklQ?=
 =?utf-8?B?eU4yVDhEQjkzeWF0bzZWWkk4U1dJZzZuS3I0bkNwN2U3Q3pEc3NlREwvc3hx?=
 =?utf-8?B?YTB0bHRXdzZlSTkxREZTcWYraEJhdVdXNUN0eVNYbmZSZ1lNWktLTmVYUzlp?=
 =?utf-8?B?aFZONHErdDEza3k1MDd6NkpMUk5yOTB2SGxmZW9hQkVMUW4rZVlOL25vZVZK?=
 =?utf-8?B?UkxlUDk2R3FYMTlPNW9GSGlDeWJldXF1SU5YUEVMQkY2bDFSUkY2TFZDZE1Y?=
 =?utf-8?B?S1NKUlJUMkcxMmFDSEVYbHJaUlk0NE45ZUZmV1pxY04zSmxmZnVqZ0RBa2VV?=
 =?utf-8?B?Uk5LRlRaUUhpaG5VT1N0S1BrZU5tMTFNbnRwQXZYUHpaVlZhcHJQL1lsUW5S?=
 =?utf-8?B?aEMzdm9qYS9nQzl3VDk5MHI5N3pQc1MrZ3BmdzlBTHVHeFNBaUcreTlBSjNO?=
 =?utf-8?B?ejlMZWlxUjNvczVNazZrNWZZSTZ3T3FRWWRvUTdaMWpjUEo1ZUxlTGRUazhZ?=
 =?utf-8?B?a2NiMnZ6OUZHYUp1cU4zUXVKWkt5QmIrV05GbmJ3Y3RKcnFnS1NZZEFXMEhM?=
 =?utf-8?B?QitrYXh5WVpzWktpY2VWdEVOL2JSbGRBNDUzTnZGVXFKUEpJbWdrU1lCZUp1?=
 =?utf-8?B?WFRXTHZ2MFlKMlFYcVgwa0FiT0ZuNXRJOWxuajJrZGtZNExIeGhrMzRZeVQw?=
 =?utf-8?B?ZXR4NU9YNkoybUJlNWl6TDFnTnZ6V3ArTDdySmFicHVoNkg1WjV5ZDBVdTky?=
 =?utf-8?B?SUNFTU5ndjJxSi9MTG5PN1hDbTYycm8rcU1yUFpJeDNja1UwRmxLSU9iMDFW?=
 =?utf-8?B?VGZqbk5VOTJyRVp2ZW1tV0tsZW96NHRsUHYxSEY4eTloeFE5YkcxOGt2SEhS?=
 =?utf-8?B?QmZ1Z0Fya3dTa2FzNEZZVjZZWHpOOHdVRlgzc1VITzdTbWxSSXppNmoyZTMx?=
 =?utf-8?B?cDlSTG9IVG1qRWZuaWpGdEQ4YUtZQllndENFV2tLd2VxZjc3M0F0dHllQnFk?=
 =?utf-8?B?aWMyUFhseXNLTWwzZWtaY0hodG5PcmhtS2U0QSs3a1hJT2F6bHJvLzRNMU9s?=
 =?utf-8?B?aEl4WFpEUVVraGQ0M2t3cFdxcTh2YTRSZUx5bEIrUmtkWXVzbHFsblA3OExq?=
 =?utf-8?B?R09CUnRnOTBPUDVmclFUdDdmM29KVDgydi90OGRQQ01FVlAvMmdkTkhubHNt?=
 =?utf-8?B?SHBpODhINGdEbmw4V2xtMWM2UmtyVGxsVFBkalFQYlpudzBtcjRKeDBmRG5q?=
 =?utf-8?B?ZzFOWTBaQmRLSVIrd2g3S0ltWldsdk4xTWxvcERqeWF4QnF3UkhHSnorWTN0?=
 =?utf-8?B?OEEvaThrMG9uYjU2TmNMWXdBMkxBc2xTWTJtVHJOdSsyaUl1blVaTDlKRW1R?=
 =?utf-8?B?UXZhOFZwdUt5eTZZUmlSNXk0UU1hb2RwOVRXc2JrcEN5Ynd0RzFDWm5aZTM2?=
 =?utf-8?Q?e8nttQeV09Ukp3GWeZlxix/bf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0pMW/hpx5/Q4S8dnCrxmSgRSzBo5S9Nh1H0esc6qrmTEXTweq8pt2XQth3lQMOmaMiYyP+4X5uazvzRSdzYp1hT/WsetCcJw3a/CSu8nR0m5Fb5l5sb9xOxb54t5SGppX09xlJxGIbYaTikfWjSZNCP/F1Yjchwdk9AelWrZ353gD2p3pIohZXHlZtglPRbmtlVZSzBw5NN5t7ZtBTEdWbCN4/7NrngRMzxVCLt9LOnOBnmLKGCxL4SRVBVy6REKRjNkv5uvf+GtDOA9Nn6eTKeRrAFVJ++wz98cAyE3wNts1vbr/jaJti6mPEBTJiKb/cnvo0t93ivdtNbFwtwU00/SCkTfAxQaTduyX8Fzz+9kFGmdXzFCzjfyjiSG+A2BEhT+K7bwm24k6L9UZS8Uj+fAWpiJgCKmVw3XNpCz7tlPQq0gNApxPY5eiA4kEE7XsI4L5AaFXjj7GFoOS314f7XLWjNyDezHUDxYadtZyY1LWjH9s3/FoMJ7M3VYLs7wb2aKAtB38lwgRLOOuWYn3CCWp18fssa13WlSOlV0m7pesOw7s7QoWzOIYAFj9ijd61AQVcRgLw0AYJTxwNO7qMSGYwY/ucvkKuN1VSjX+Ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea64e3be-144f-4356-8d15-08dcee08f0ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:35:35.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9px9l6rgdujeTQmE2Xp/AH8K+E7bp/xTznDFpp6v+rZ7SA3OOCcK1ZPNaWqB31fKj14t2UYNxA1AYS3aGwqqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-16_13,2024-10-16_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410160113
X-Proofpoint-GUID: Vl_JCHKsxYeq6SwKKauHbU4CpYXfmVcm
X-Proofpoint-ORIG-GUID: Vl_JCHKsxYeq6SwKKauHbU4CpYXfmVcm

On 16/10/24 07:27, Boris Burkov wrote:
> We have a longstanding bug that creating a seed sprout fs with the
> ro->rw transition done with
> 
> mount -o remount,rw $mnt
> 
> instead of
> 
> umount $mnt
> mount $sprout_dev $mnt
> 
> results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
> critical btrfs cleaner thread.
> 
> This test reproduces that bug and detects it by creating and deleting a
> subvolume, then triggering the cleaner thread. The expected behavior is
> for the cleaner thread to delete the stale subvolume and for the list to
> show no entries. Without the fix, we see a DELETED entry for the subvol.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - update to real copyright info
> - add extra rw->ro transition checks
> - remove unnecessary _require_test
> ---
>   tests/btrfs/323     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/btrfs/323.out |  2 ++
>   2 files changed, 51 insertions(+)
>   create mode 100755 tests/btrfs/323
>   create mode 100644 tests/btrfs/323.out
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 000000000..ca57b1a1e
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 323
> +#
> +# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick seed remount

This test case includes device addition; please also add the
'volume' group.

> +
> +. ./common/filter
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_scratch_dev_pool 2
> +
> +_fixed_by_kernel_commit XXXXXXXX \
> +	"btrfs: do not clear read-only when adding sprout device"
> +


> +_scratch_dev_pool_get 2
> +dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
> +

There are predefined variables $SCRATCH_DEV and $SPARE_DEV for these:

_scratch_dev_pool_get 1
_spare_dev_get


> +# create a read-only fs based off a read-only seed device
> +_mkfs_dev $dev_seed

_scratch_mkfs


> +$BTRFS_TUNE_PROG -S 1 $dev_seed

$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV


> +_mount $dev_seed $SCRATCH_MNT >>$seqres.full 2>&1


_scratch_mount


> +_btrfs device add -f $dev_sprout $SCRATCH_MNT >>$seqres.full
> +


_btrfs device add -f $SPARE_DEV $SCRATCH_MNT >> $seqres.full



> +# switch ro to rw, checking that it was ro before and rw after
> +findmnt -n -O rw $SCRATCH_MNT
> +_mount -o remount,rw $SCRATCH_MNT
> +findmnt -n -O ro $SCRATCH_MNT
> +
> +# do stuff in the seed/sprout fs
> +_btrfs subvolume create $SCRATCH_MNT/subv
> +_btrfs subvolume delete $SCRATCH_MNT/subv
> +
> +# trigger cleaner thread without remounting
> +_btrfs filesystem sync $SCRATCH_MNT
> +
> +# expect no deleted subvolumes remaining
> +$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
> +

_spare_dev_put

> +_scratch_dev_pool_put
> +


Thanks,
Anand

> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> new file mode 100644
> index 000000000..5dba9b5f0
> --- /dev/null
> +++ b/tests/btrfs/323.out
> @@ -0,0 +1,2 @@
> +QA output created by 323
> +Silence is golden


