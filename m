Return-Path: <linux-btrfs+bounces-2835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA51868F97
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56DE6B26447
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F4F13A257;
	Tue, 27 Feb 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/AwdU9v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wqv1ExfR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559C13957E;
	Tue, 27 Feb 2024 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035303; cv=fail; b=XsJqs1VgJptE89N1nF2uGUF9nUklb1zySwvbS71qu7GfXKfpO/8yAJp0DY4v7YQCDSErPH4HdSdYyasQ0vXCqeNhZo+b1uH77mkwtl7b4z65/HtsJYZwaGmrSKx+j/D7bqoIZqp4++QUVd+GQb3Dk768HJsHX0uMYDwdWHKbE0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035303; c=relaxed/simple;
	bh=opeApBSRqnY/Nqs02+jWcCTtiIMg0hs801yTFWsw+Xg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KdsRDIRXDdGEzhzuWFF6qIvqM5CCXv9VHexdlpPuyTWogPsQH6yFkFTKDdcTNaTdTTrKO4aJzgk4e5rVqGq9JiZ8joLNxfxVn1SyDPSPyRRnws4WBnk/xoaeShe2apPg546TjBi6qxANiOpz1PotRApXcedVgsX4mgvRt+cBhsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/AwdU9v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wqv1ExfR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R9JIG1003174;
	Tue, 27 Feb 2024 12:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Smdkzo+99A+W2xLYjEEy071QM8QoAxfz7IsHpW6quCI=;
 b=c/AwdU9vZsqniHCESLPyQQFx9C5s3/nLI6EEN51dxQv7HwQDsv0EgAyn9+S7vQro2UVk
 ZYxjzEjLSGIXGAEBHCFXIxqlKGlDb95L4uCUs0F0zOpYMfnH3lp2jgzQizHbwjrRkmlO
 DxjGp7bnjm1FBdaIy1hRHe33/bCPTeuszZjtOY6m8GLgsq1/HwP/mMydm4zYO9tpIKCK
 RlFYXcBL7+rC59ZjD4jWf5nRfFJVVkNQIslhxOoo6Q7qkcOAodQ0cvGj/oaKSnLrPp4w
 oFR4votwSwfTf/Yb5Kx+iaWcCFQnHhlOUvy1M5zAwoR1R/4A1bQuBLiezM9ycCqumiUp TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf6vdy1q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 12:01:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RA278m025680;
	Tue, 27 Feb 2024 12:01:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wdjtdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 12:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJEwjpJrg/bqkXZGmK8jXE40FaRk4tehkoXMG5WFIqd6btlAuSuoU3VvTua7QC733+lM/dcBKwXKqp82w+LLAJ1ljmZ4Mj5v9otnVvS+JncNiOnpHYbjm3mCJgaOKnDQyDUPrsVze2LP03rSi7rKjifDxeECg3jH+suq2Ks862PxnYUSed+DpxC3fWU9RT4cJeqVUKtP+Hh74ycxNi7JKq9oCvzoS6Vw1blk6CNtpj+rL+Djp+oRsrYl/Cq/UbBPF4sXcEA4O/vorthU5K/TVSQxe55XAtweEHkTNhFPE92MF1HYFC9K0ZRsLf7Evn6P9d85SsZpmdY1djMdaYOZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Smdkzo+99A+W2xLYjEEy071QM8QoAxfz7IsHpW6quCI=;
 b=lQZ8S6M01nvsvB4zndSvJTLKvpz+T+gQRuwp5MYSajhb4H/M5pNXPufztkONN/h0GbhtDdgwhxKhARZPqB+dLk1LdiVjefi1PMFf9ci5FTcNfDObYIjvTc1orhMSHfBR3NiY639QOA+JLs8WqU41y1dXlUgqotX09vHD0Epa0ADHCxSo96+dd2wJtG5rvTSm98NRnxU7GVxHCy/w/hX5/E8B7I9bM5U5Lzr+MsTXO6EQtGsqy0HHA8FD+l42PpnXn0pOABqZcx3DeP8vG+W/mRqlMAMGgVdVKwctXXzGUjQYUd6x7oQcgArnTfrFFGGy35JME6uIOWRzLxxetKrCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Smdkzo+99A+W2xLYjEEy071QM8QoAxfz7IsHpW6quCI=;
 b=Wqv1ExfRcaZUaroA6BkChLsCl4UGgQHfEKKPH0swa6+vD6s+pt2E1fZPNsfE7/mx313JdZqLocnrQsdVDHCFDRZdppz6ZMUqyjgt347l1ebPw6GhywGM4ksey0KCzI2BvnQowH70yR8NlJfTeh2kJ6tpp9Yk2k6QqFkk7MAU9xk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 12:01:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Tue, 27 Feb 2024
 12:01:35 +0000
Message-ID: <595c0a6d-77cd-4949-b361-625cd92e67e5@oracle.com>
Date: Tue, 27 Feb 2024 17:31:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] filter.btrfs: add filter for btrfs device add
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-2-79df5d5a940f@wdc.com>
 <43fbb951-664a-4224-95d0-a8011495d698@oracle.com>
 <e6e04661-eb57-4239-8246-6d4bfbb813b4@wdc.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e6e04661-eb57-4239-8246-6d4bfbb813b4@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2a5b4f-739b-4640-2140-08dc378bd8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CBTrgDbmb0pe+MShqlmgXdnWkZPWg7wiG4h44IbQAIeBizX82ICh/vcu0Wm0wEgQ02uZEdzXXtT3tDY/dgzKFa69JcnE6iRrLHp7aibtl9cJskOWjtciM4jxHTRQG7lUsNSEXhz0gb05uwtZP+GDeA01qPaJfQ9HxqZyVD+pAt65M6CrtTNlXv/OtWqsgtluOiXvIuRkKp3HcMjT9E5YkQrTKInWVxpIxAP+KA/xaxCtIfKTm7A+Ctpf4uZBPf8NhqH/4pdaFjGP1NJZRuwXQOaas+55Nvws46bRyMy1xVCGEt+QcQYNn1OPtc6WLGZjr5VXWBetC+jju8DajZjhwVK4dobc1N97jbm6q/0hIJHdpcRTBHUYWK/wUNWSkWlUl+RUYw70jxRx/TDlC+QoJgWDNMkqXqqCUEEDziaG0lQQ3FWuk2bj9PjuQ0SnRyS/3JHKlUzQPKbe05zE+fihXei8+8279hP9m7X4X1Gq4J+2ALq/D/eLjtJ+mrizbDAUhWpbXxI4wbqybHjZhltO5skP9Jmgb4Uiay6a26wi5YBKl3BVfp/Bp0RGeocLgz+VQtG3eHvUyGbVwsEryjl7iINQMagJFjX7rcyuJ6uZ1SLjXxP46GyP8ajYKOvhRh2j
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHdiQ0RmbHpWWU1OQlpDQ1l5KzNCOXQzVFJSNC81MjVjZnNtc2FRUm1GbWlu?=
 =?utf-8?B?c2Nub29QZFBUK09DVXJ6Tng4aHA5V0t4OEpweFlzVFV3K1FNTHhRN2VGdmQr?=
 =?utf-8?B?dU9mTUVqdlpNekNrWXRNSENEd0lTeEF2aDQ1NHd4NmxhZWNyU0ZkQWNiRFZQ?=
 =?utf-8?B?Q0wwNVZsd2I2NFByaCs1V3djdVUrYXBTZzUvNXFsYlUxeElGSi9IN3BKN1JM?=
 =?utf-8?B?RzRXS3FHekdtQjdZZHprREM4Y1hXVzlGQjM2Q3FiRDUvQkp1N2NWMGZ1bFds?=
 =?utf-8?B?Vm1IN0p4cDRhYVlEaVhWd1d2NlAyMHphNzZjTlBOekZNK0IrMGR1VEwxekJs?=
 =?utf-8?B?S3FjRGFTZ1hKTHFQcDNxbDRFWGs1d2dZZkNDVjdyWG1HSFZLZVhRdFR5TDJr?=
 =?utf-8?B?ZDNqWmwySHNqcGxCWEhqV0ptMHRtb2hPSWV5enpIZk5zMnk0K2tOL2w1REpR?=
 =?utf-8?B?eFVaeHVoZ21sdkJiVlg1eTJMNXpFR3JFb20zVUR5OTMzYlpjSVJTZjFZeGlV?=
 =?utf-8?B?RC9JdFdmSnlsSS90M1VZREx0ZFBKYzEzbWt3MjRJeTFzUXppMFBySFVET2dz?=
 =?utf-8?B?VVhPTWFjR1hHOHo4ZzFEcXhxSDF1a3hPYXJDbkg4VGtCUENseG91dExaSUwv?=
 =?utf-8?B?ckpxVDFlNHEvT2lxZ2pONGZZNUpmdjk3OWRZcE1HbVR4Vm9QTmhIQjQraFBj?=
 =?utf-8?B?SWwyQi8wQVhlTmpUMFdaUnVhdm5KZlluVldTWkRDN2JQWWpkZiswdk85dmwv?=
 =?utf-8?B?UWlEM0VaNXRiMHFtSlVXODdNMzJkcStYVExPZjRjTGF3TlJFUXNWTXZBVmlD?=
 =?utf-8?B?NjdKdE1wc1BJTEM5VC9DQjFVandLWW1nZ2QvOUliR1FKcEJtZ2VRamZLc1hj?=
 =?utf-8?B?MEU0aFE1dm9sRmpNckNIUlBKT3J1WDdka3hlc05aKzhoR3M0MlljNHp0Qlo2?=
 =?utf-8?B?Q0NnZC9adEdCUm0yM0FHa0QzM3J5Y1YrUFd0eWJQbnEvampaVjZteU8rMVVX?=
 =?utf-8?B?QmZmOTV4WlFHdXBLT2ZrbU92QitMS0huZ0swRTJZR2JScjJVRGxNTm9Jb1RE?=
 =?utf-8?B?ZEtxYWxHdjdVZ240TU91N2g4WS80aWY0YVczRmx1WGIva1BIYnVrVVc3NWJp?=
 =?utf-8?B?cGx4NUF1T2t0MUoxQU5FL2ZnL3ZYQVhQdUVJa3kvN2JES0RKQWFxdEZQT21o?=
 =?utf-8?B?Y0orblc4SnpCS3BKNmY3SGxFMHZkL3NTZjRUZVdzRXF3THRKN3k0bmhqTmlh?=
 =?utf-8?B?Wk8rcW42QlE1Q0tBSDBXeUFIckZLZXo0WE5IOHMrZDJUd3hDT3JJV241TGE5?=
 =?utf-8?B?ektnTmROT2RhWHJKNkhnSkpYdld0dWRyMWNRbFdDdTJMbG5TdnNrbmQ3cHNQ?=
 =?utf-8?B?NzZ1M1VzSHdBc0ZDd0hUSXJ4b1BRbWxZYzVqUGt4dW1hUzRTaUZKVnJVb0w4?=
 =?utf-8?B?MjFEZlhtSHo3QmlVV2ZXRmJPWng3aGF6bWdoL1RESHFLb1FwMElKUFU3bVE4?=
 =?utf-8?B?SE5Kc3liU25LNDJvazRuaExUc3hMdC8ydXBxd0NxVFpSK1VONFZpcFdRa3BS?=
 =?utf-8?B?SE03NzE1dWc4RDVuYW1tUXNkNFVvRWtPNDJnZUpOYWl2UzMxdDR5VnlJczBW?=
 =?utf-8?B?UHZVdU4rMGExR2E0OXZOUE5JYlg0dnp5cUFnaW9mNGh4YkVsMG5XK3I0blM2?=
 =?utf-8?B?SFhQMlFCa0NUTnNYd1F2Z3FPUjFTSm80TTMybzF3RExPS0w2TU4rRFR0QmZU?=
 =?utf-8?B?L2MvVmUyMnJOcFlnQUZEdFp0UWxDQk1heFRoOXlmMG11cGN3TDFNdUtFWmFr?=
 =?utf-8?B?UVR5Y1ZQVHlKQ3dRQ0VBYXRNenJVZlJjclNqMFU4UHNXMDdFeS9NME9tTkxn?=
 =?utf-8?B?Vit5OXR2bEdQcU94L3RNVmhFK2pLYkM4OFE4NXRWYjVLRGJzL0VJQkQ2RFl3?=
 =?utf-8?B?SGE4bC9wWkZsWFFaVHpaUUloS0l4T1BoR0hmR1RtYW9ZZWxTbjdjLzlJeTFh?=
 =?utf-8?B?Zmt4M3hLSDM3RUQvcmZaMWMzMExDNWdvTUd1SEpyc054NDcvdHV2aHgyUTU4?=
 =?utf-8?B?R1pnOWtrUHF4TUN2K2c4WGJUQ3QwVlZ6ZnBNQTUwblZTRDk2c25iUG9tQ2dH?=
 =?utf-8?Q?HcsXmNSNIO2Di+rZKvln4AImT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0h0a4KqZa8bwQd7zpwBGt+hC5LQ6qRJI4s6pCLM7dSBY9AW0hcxVy5QUs+hosll3sV/mrk+nmqbAAcYvDUW77CAPeFDCj//V1FNlOG9/v9dDtZFdA0xHEpMiZvtk1Ti62NZ01dzBcQ/Ae+iaE5YLIi8cpBVCS02BGtq4C31sg88mGhHiNJwOFx/lynY09YJ99jB4JHCDp8fjXOalejtgdovbR2Q/I3JKELuXTUM1/INgwzW/3U6GtgsgKd9P58/q87ajgMaArm/j95fke5bL46DQpUsaRTVP69/Hc+UDBm+z9I5I/q0g7NwU0fHEWdBnd6/v5QnCrnwF3FdLpU97vjCeU+bCCyFiTxG6BntyI5cNViue83PN14vo3R/WOkYebYxih5iCGYGLxYtjWAbadaOT00w57cIvfHFxOqR50eqzRDfz3dhq0rGQwU/dIBnIPxJpa8q4yLVI6R0s3OzYLWzT8PpvJaGrVwdvKF9ATH9HmLSLTGVZm2bwZqmnebYJiGCVizPFNqPKc03VduDsSLWpxIurjvH95HKkTAHodQhwjh7y4HUP5GxZFhXTznOQQlBLua9tpuUO1HME7dMoNKHx1dmYxZYoDWqbPfIqvus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2a5b4f-739b-4640-2140-08dc378bd8aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 12:01:35.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daqGCa74ZxII11l02QrD6NakWNbsYNjDlzSwaV1atFZC7ewtzR1PPBKFY7X1o/V3Qq8ca/Nm/OdlxT7A2SruIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270093
X-Proofpoint-ORIG-GUID: H-Nfb8EHqb6BlHTgpeyME2G06874krtz
X-Proofpoint-GUID: H-Nfb8EHqb6BlHTgpeyME2G06874krtz



On 2/27/24 16:48, Johannes Thumshirn wrote:
> On 26.02.24 18:16, Anand Jain wrote:
>> On 2/15/24 17:17, Johannes Thumshirn wrote:
>>> Add a filter for the output of btrfs device add.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>     common/filter.btrfs | 9 +++++++++
>>>     1 file changed, 9 insertions(+)
>>>
>>> diff --git a/common/filter.btrfs b/common/filter.btrfs
>>> index ea76e7291108..a1c3013ecb5d 100644
>>> --- a/common/filter.btrfs
>>> +++ b/common/filter.btrfs
>>> @@ -147,5 +147,14 @@ _filter_balance_convert()
>>>     	_filter_scratch | \
>>>     	sed -e "s/relocate [0-9]\+ out of [0-9]\+ chunks/relocate X out of X chunks/g"
>>>     }
>>> +
>>> +# filter output of "btrfs device add"
>>> +_filter_device_add()
>>> +{
>>> +	_filter_scratch | _filter_scratch_pool | \
>>> +	sed -e "s/Resetting device zones SCRATCH_DEV ([0-9]\+/Resetting device zones SCRATCH_DEV (XXX/g"
>>> +
>>> +}
>>> +
>>>     # make sure this script returns success
>>>     /bin/true
>>>
>>
>> Works well with all zone devices.
>>
>> When only the first device is a zone and the rest aren't,
>> you are seeing.
>>
>> -----------
>> btrfs/310 1s ... - output mismatch (see /fstests/results//btrfs/310.out.bad)
>>        --- tests/btrfs/310.out	2024-02-26 19:17:51.092325188 +0800
>>        +++ /fstests/results//btrfs/310.out.bad	2024-02-27
>> 01:07:13.097603491 +0800
>>        @@ -2,11 +2,8 @@
>>         Done, had to relocate X out of X chunks
>>         ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
>>         There may be more info in syslog - try dmesg | tail
>>        -Resetting device zones SCRATCH_DEV (XXX zones) ...
>>         ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
>>         ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
>>        -Resetting device zones SCRATCH_DEV (XXX zones) ...
>>        ...
>>        (Run 'diff -u /fstests/tests/btrfs/310.out
>> /fstests/results//btrfs/310.out.bad'  to see the entire diff)
>>
>> HINT: You _MAY_ be missing kernel fix:
>>          XXXXXXXXXX btrfs: zoned: don't skip block group profile checks on
>> conv zones
>> -------------
>>
>> I have the kernel with fixes.
>>
> 
> Ah ok, do you want me to update the whole series or send a follow up to
> fold in?
> 

  Just the fix-up patch for 2/3 is fine.

Thanks, Anand

> Both is fine for me.
> 
> 

