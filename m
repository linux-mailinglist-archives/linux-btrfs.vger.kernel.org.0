Return-Path: <linux-btrfs+bounces-3494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D7F88592C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 13:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76959B22A9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F437A13A;
	Thu, 21 Mar 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aVumKiL5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sILo+fjJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79871CA98;
	Thu, 21 Mar 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024489; cv=fail; b=Em1djo4/iyZmbDFk4zSyGdU/sNkGtSJUFepOipye6StGbccLYwE1bWk0kXSE6Df1BbvRz7mtQG/TeIu+T/ZCELS0WGqesFjnf+rbwLdnLqN21KNP/FF9QPbg6wtn0M328M3KjZMgXcGQiWZYexWbbZidKVJY79SaB+Syp0n/4l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024489; c=relaxed/simple;
	bh=QOpNdneRslJotZfMwBruNJIGuNabrE560l1ABnpyBmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YHsNEK1182ZyfwU5PBKVDyKFhMXJ4CArlniHHDNOPPC4JUHqLqGl4x+5JRczguGCfjdRtuiFnQ0m6qPTvQB041j19m6trxeGqyy7CinW/TfLi3wM0UyBvrPkbjqKsaLvf3Py7sQcV3GqVAtHPn1c/aAO3TqMI8c1B6hgbQmL30k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aVumKiL5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sILo+fjJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L24T3a028699;
	Thu, 21 Mar 2024 12:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6QiPIZ+OjNydinmZi/8kDsj6Fp5azduTB+MGqYnhPVk=;
 b=aVumKiL5vJ+uvTN5CQ4yPuEec0GealFm1CKpjtYHPFc8QyctVecpX0C56EtVZfG+XMIq
 NQC9yXCXxejDAN8/BX+hY3NpNRH/cpmNo5MmBDnKzxZqDBssDqDuWFwey5m/k4ZflTZV
 bcc57TO+Mt7F96y7jqBp8MT42yHH1fRHBVF8rh8CLbM4ULchJWXHMxXwTm1dfBsmG2eo
 +n5F9pA9LZFe+8xVR6oLVe8qFmwo51hYvpePmx9JFD+jtpWjr4QUcb2EhAMVmf29QQaa
 ELrwKUB88I3Nl1qzA3kinKs29PMaBrvZcGQRBFP7IJMLKi9uoZu4kOMqp5y+m1qcmrJU eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2bbtbxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 12:34:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LCO66t005993;
	Thu, 21 Mar 2024 12:34:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v95rys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 12:34:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtVJCVCwPyPxNlJ719RACjlT1NhI6L8lpH0Qbs2RelWZs0By8zRu7d0M6JGjN6W6TjrRTl9APu0k6NCOP4PNEwX3PcE52pzgfZ0OE6OeoiEymhaDRtF9tWRP2NAzFoqyc+HcyxSoazBVPm+ml0meK1BmvGFlcvnQaH7G80xLLwmsS9SC35pVbNDoRRQU6oDnm0Cr+u9qmt7jbs2YPHeRbBszt9Pqt6dgezNEDov+ZoaT2Wgs8GMYbRRs4JVVOXTwfht3LWJv+GSgUqfy5jvaTAhh4QsR98IautsuONb5xCeTxEF0tiBvSi20UK2Q4OcdcWRp5jY2WlBVqw6SCgb4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QiPIZ+OjNydinmZi/8kDsj6Fp5azduTB+MGqYnhPVk=;
 b=MBHiQwMYE5dPj9R7M8zpIL1qtIr7j1o8wKWF0R50A3JrB/CSWfvqrVvhIqT8D1JNuYnVaDr6xTA6v66wnRqsIomdguLTX1NS64X3QFSvI27IdZL6NtzGjkNGW62syltt3qUBS2AKx7V/98W5Yr6Rc6n97aFmFxxD1Ej6vkWkWWmO0E4l/VpeRDBv4KsmrsBoRwT2fqES+iO+PDhGoBVdVqGnhleQEInTGDKZo8qqaIOcCjrUaRyeuH0hHwDAEglsvQPmjjZl0Bdvd9YgY91/3KUyFFZr1HMMkM4/tupUnHLPUTEuAHwax3yoIkb0o/h0Vc3kfubv4sSmoSy4n63Quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QiPIZ+OjNydinmZi/8kDsj6Fp5azduTB+MGqYnhPVk=;
 b=sILo+fjJJ+BTSgqOjwPPgIsj/PIyvaxeeS8yNq/Yr5MCQ9+rZIXYxoCL2pWxYJVMG+nd3tVeqrMn15L/vwoUFZ7hwesekancmalU3ac0wkGvhbofL+RwWwtGdM4xmVOsXtla6JTrPuwTP4Prb1lSVxr5xy4PszwkyUtsok4QRX8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 12:34:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 12:34:18 +0000
Message-ID: <9edb0930-f42b-497c-9f1d-538341ce0528@oracle.com>
Date: Thu, 21 Mar 2024 18:04:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: set BTRFS_CORRUPT_BLOCK_OPT_<VALUE|OFFSET>
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <cover.1710871719.git.dsterba@suse.com>
 <eb2493499d2f30f43afa09e980589bb4f15e9789.1710984595.git.anand.jain@oracle.com>
 <CAL3q7H4nJgu+b8OPZHp+0TRWpPpnaeTen44udZG7980Lvh028Q@mail.gmail.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4nJgu+b8OPZHp+0TRWpPpnaeTen44udZG7980Lvh028Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 210b5b5b-9bce-464b-d9a0-08dc49a33a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xC7hn/RvJdNke2VPGlmfIxc/HqbUiH5njD0IwGUBw9JV4c/cILnFBdmJtsGVwFjn3yHnst86PKDH2zUnxZMC7/g6aZ4SS7n3HMIBdNF/F0vtOE+2oX5zXBCSg30SHe1eG+etBuC32HeK12ubNPec6Q+Xbc5btOCtTCr1OQKZ+Np7fZ4N3fxpzflYUmJAFuCXFTEiFqWDEabUWwM0PpxHiF6mUuccnvy+zb0Ga+/Fex8A1NQccmoXk8u3dRFveNmbDjLwpMbGahX4lEK8Zcb7clfgdfIh/TjOGP9yo3MV5AS0sdYeKj/Y8JAp+RUOWUrJQyx5o0o6Ne3lhjGuURc4voZsbxbiD383CAFayvSHA+3U8+YqRO5h/0BHcdd7m/KMxNnn8GKyKIu5z4uag7PkGWcqIIbNwfyylhQHjRoaryUwTD6zqrMXduAH+l8VUMMlUozDFAxKy0e0LY5WktZqYjeCTuM8lPM43LWWso8hnogkp5UhHuahpheuWVtp8TgWmmnPsurmKJK64T0ljq1tYzCdZubGvXGbE4+Q0MsxE2350gvbPeBFXgvxdS7LLARe9me0XyPbh386D6PwOhqqupOmLU5me5TpwaR693i6VoqzeLB8/B8Jh+//p2dLGUCQdKXMha1GN3rOjT6myrfpS1W0QOkPzu5IPettdoQCU4Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUxYZjd2WjF4cVQ1WlI5THpDeTlQL2l3LzBUS1B4UUhZL205djd6ZjZyU2dO?=
 =?utf-8?B?V0EySWFxeTYvb3RsZDNWZXZybVNKRTUzUFp2UjFkcGpuUW85S1NTV21wWjZn?=
 =?utf-8?B?QXRRS1NXNFRSaUhTVWdJRjFhN3psanFsaXpzN01kSTZYOUNLVW1qK1JSejZq?=
 =?utf-8?B?NnUxOXJMOEpKUVBKUHExUkNYMERpMzVFUVRGN3RBOHZjT2haRVFFR0NlaGw3?=
 =?utf-8?B?eXVXZG5HUy9lWnUrcEdWMDFSQU5Zc1lHV2VrdFdOSVBrS3d6bHo5UVJoQ0xP?=
 =?utf-8?B?UVhRY3VWZ1lOWEFlUzdLUkQ1Q0J3ZXlXaURRa05jSjlVeGhwN3BrNTdxcStZ?=
 =?utf-8?B?MXg2V2c1YjFVOWRlOU9ZTUFiL3J1aDRZVDViT1N5bHpNUDNUUUFMU2YxV3po?=
 =?utf-8?B?dWVVa29wTk1tNzYvaDVWQkFqWlBtbVhBdUFIdmZXM2ErVW9wSktGNTJLdGNi?=
 =?utf-8?B?ZWZsblVyRmV0bVlyT2JwM2dJRTRtTy83OEZFb1B2akNIc3FpQm1OcUJBWE0x?=
 =?utf-8?B?MUJtbEhkV3FyUU1tSGhGQTVtSWNzUGg2YU1jd2ZrQlgzd1hrbmJWd21QNlNH?=
 =?utf-8?B?Y0pxT29DRTV4cnp3YXdzNnBVWlN2dlNHRUdVZ0EwbzlEOVBuaXpVdFhzbVpE?=
 =?utf-8?B?c2QxMkRpRGV2Ykx4SUVZWmxCeWQxTGduNld1R2JvK1hNQzhMUGllSlh2VFVO?=
 =?utf-8?B?YTZyenZ2bDh1RG1kUWZqR3RnL1dtTlcrZTVQeXMvejJuSVBDTkN3aG82ZEZl?=
 =?utf-8?B?cWYxS2JBZUVWYWdUeHhKcC9qc21hUWVjdTdoMHpjc1NnUVZaVVRMbUxYcTRl?=
 =?utf-8?B?Q1ppcVRhV0YrbW03QmdHRVM5cFZJMkhNOHJYYTBQb2UzR29QNDdab21Ndzcy?=
 =?utf-8?B?MDhibzRQRHlCSnhiMWV3aG12OFJLazFIR0JVRzFCSytUMmdSZnUxSlVLbmZW?=
 =?utf-8?B?eHcweUpMT0FZV3Rwa1ZsSUxKV0pMNUhjS1JQdEtzZ1FOb050QjE3alRKTms4?=
 =?utf-8?B?UHRHN2FwcnUwd0dza0ZoZmJLRW1xS2wxSHlJS2hhcTI1V21helBFRm5uNXQy?=
 =?utf-8?B?eTZpRWYrOWVXakZUMkFUQURGS0FzOFo1Tjh1Vks2ZmdWemx6VVJsM0kyc05a?=
 =?utf-8?B?SktxOHRIbzJORHVVRUxHYkdTdG5IMHBFSC9FT2FCcmhQNFRGdmJOclNnWndp?=
 =?utf-8?B?Q1JmSGVqTEdHRjR1YncvN2RWYW1kNCt5SWtDNlN5eTlzMG5teWVFTlBpQ3hF?=
 =?utf-8?B?VEdqdEJaaXdYWEZxVHV3T0sxN3FzNWhSZExsRVdVQUk2Sk82U1NWaGdOUlFh?=
 =?utf-8?B?c0ZBNDJpUzdvZmxmQUxCV08vNzdDNkpLblNCRUJkRmpxV1kyd3ZTVlB2bTVu?=
 =?utf-8?B?T0FJM25NU25pNzJ4a2s1d0RmeFUvZXlxVnBHcUtTR3l2S1dYNDFiWHYwdUFU?=
 =?utf-8?B?SEJscnl5Vk05UTY4MkdXL3ErZlRWMFFDSTEzZWxjUldkTFExUEdtZEpMblVl?=
 =?utf-8?B?d1JzOHovYmx4TmIxY0RYWEdyakEzMExQTEwyNlJjVis0dTdJS1laVnkvQTJy?=
 =?utf-8?B?Q0syRkJPdk96aG0wNkJqNjVuSkpWNEl5bzFsK1B0czBnMFFDalowZWtkcTRW?=
 =?utf-8?B?aS82TG1BakNVTmVucjAyNlIrSUQ1QlJUQUtDUm44TnNoK2Q1VWdIZnpwVmNy?=
 =?utf-8?B?dkNxRkNCWU1LWWlublcyemFaYU41Sm1ieCtxaHhmb2JxZzhpRmZSWktiVWxT?=
 =?utf-8?B?eE5MN3EzOHBtU2hMTG14RFBlQlArWmJBc3dLS0pmVXRwWTZZd0tLYmpEdG01?=
 =?utf-8?B?c0VDQk9xdkpYeVJPTHpEaDgyZ1lIdE1qNmlWT2sxd29jcTF2WlNHVlc0Zmk4?=
 =?utf-8?B?bjlRMlQzMGFvV0ovaGJOemorbUVVZ0E5YWcyQldzV0JRYW1DSktubXBodlVL?=
 =?utf-8?B?YU5BcGx5emFCOTNDYzFjZjFKOFdMSGU2QlZOTlZ2eVJaK1lDNzdKOGQ3ODJT?=
 =?utf-8?B?QXByKzAyZTBrSGVIU0xmSmU5NzZQTHpjcWxMREhJd2xMR2lmNmdnOHBsNitK?=
 =?utf-8?B?dDhraVZnMUZFeE05aVF5YjJBbkJQckZLcmNXUlUxazdzSHhPZG1XRjVyZEZV?=
 =?utf-8?B?L3Y1UFZsOUJZcVEyTHdLek11anJ4anZ2ZzdhaHJYdFFRc2xRcXcvcC9zRHcv?=
 =?utf-8?Q?Sp7cx5oUVHLmzEI7GFZDsw57rVoDyYH353X0aCPrOrq3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xgJKRus51sTQtgla8mfbqqAvy3h+EHxjp+pkR2XNdnFLK+nlPjMcQ8xTRIQEN1xCE/3VIGBU+XrgsKcr+noxhs0bbGjDcshUN48xsuZeU8YRtHkzI2GWMaNN2ndKwkMzR+yJB0L8KWETmBDShG6feNeOiwJ7tq9JaaWHwSXpCbL3lW9vWNl3bXHq2DLsnQiapWumDYvyw8JLOSW+ZNuAfE+HE47GgzBs+SIEdWH+L/ynoYKKIXf4MN7XFpME2AeyOoJjm/MTcl518qlgHeiq7G6KF5UNty6OHPI9XX0tjVqLsn7b9D5wtTbUg7IEflLcEZjlvPAGwb8iJd5Mt2gX41e2juK9YpL/HrF7mcZF2JkJ1UrPN9aowowuOhScM+uNcLMuCbKAqh9HAIAnySobb14gixbG/dT4srJBNPXqRcTWpJzyHLhzNcm5w5/GXBZB6tuSHGbDZs9ZS4wFAAUPg1ocJW6OzIEasJQG9mD1DNunBonIA4izM2f9vjgI5wa6JFRlZ/JvkwlY+U62G/dsAaTBY1utleXo9TB3UagnSQ0jzKjO0U5vP2X+NzhWhnw5AkjoXiemVVTJFmhDCMXTpu6XZ75dPrp3gTCQKpV6p4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 210b5b5b-9bce-464b-d9a0-08dc49a33a09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 12:34:18.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU8xFVQpeXkIBUA8nP5P1S2l4TibskCn2198Umw9RMrLpTIwlozM9bnVjPmoHZDRGt5+0xuW7lpTaeiU3FfO3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210089
X-Proofpoint-ORIG-GUID: Svlip0vHG5gBMYCiE8miIm4OLQnFSr2b
X-Proofpoint-GUID: Svlip0vHG5gBMYCiE8miIm4OLQnFSr2b

On 3/21/24 16:43, Filipe Manana wrote:
> On Thu, Mar 21, 2024 at 4:10 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> As btrfs-corrupt-block now uses --value instead of -v, and --offset
>> instead of -o, provide backward compatibility for the testcases, by
>> storing the option to be used in BTRFS_CORRUPT_BLOCK_OPT_VALUE and
>> BTRFS_CORRUPT_BLOCK_OPT_OFFSET. Also, removes the stdout and stderr
>> redirection to /dev/null.
> 
> This is complex and ugly, but most importantly this is not needed at all.
> 
> Just let all users of btrfs-corrupt-block use --value and --offset,
> because there was never
> a released version of btrfs-progs with the short options available.
> 
> The short options were introduced with:
> 
> commit b2ada0594116f3f4458581317e226c5976443ad0
> Author: Boris Burkov <boris@bur.io>
> Date:   Tue Jul 26 13:43:23 2022 -0700
> 
>      btrfs-progs: corrupt-block: corrupt generic item data
> 
> And then replacing them with long options happened in this commit:
> 
> commit 22ffee3c6cf2e6f285e6fd6cb22b88c02510e10e
> Author: David Sterba <dsterba@suse.com>
> Date:   Wed Jul 27 20:47:57 2022 +0200
> 
>      btrfs-progs: corrupt-block: use only long options for value and offset
> 

> Both commits landed in btrfs-progs 5.19, meaning there are no released
> versions with the short options.
> 
> The reason btrfs/290 is using the short options is because the
> btrfs-progs patch had just been submitted shortly before the test case
> was added.

fstests commits introducing the short options.

6defaf786e80 btrfs: test btrfs specific fsverity corruption
ea5b5f41fb61 common/verity: support btrfs in generic fsverity tests

btrfs-progs:

b2ada0594116 btrfs-progs: corrupt-block: corrupt generic item data
22ffee3c6cf2 btrfs-progs: corrupt-block: use only long options for value 
and offset

Good point. They are together in 5.19; they should have merged instead.
If any backports (which I doubt), should occur both patches.

Although I looked for the commits, I didn't notice that
there isn't a release with the short option. Thanks!

I found it ugly too, but I had no better solution.

Now, it's a relief that we don't need it anymore.

> However what we need is to have a _require_* helper that will make the
> test btrfs/290 not run if we're using a btrfs-progs version without
> those new options.

Yep. I'll send a patch.

Thanks.

> 
> Thanks.
> 
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> This replaces the patch:
>>     [PATCH 1/5] common/verity: use the correct options for btrfs-corrupt-block
>>
>>   common/btrfs    | 16 ++++++++++++++++
>>   common/verity   |  9 ++++++---
>>   tests/btrfs/290 | 30 ++++++++++++++++++++++--------
>>   3 files changed, 44 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index ae13fb55cbc6..11d74bea9111 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -660,6 +660,22 @@ _btrfs_buffered_read_on_mirror()
>>   _require_btrfs_corrupt_block()
>>   {
>>          _require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
>> +
>> +       # In the newer version, the option -v is replaced by --value,
>> +       # and -o is replaced by --offset, so normalize them.
>> +       $BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "value VALUE"
>> +       if [ $? == 0 ]; then
>> +               export BTRFS_CORRUPT_BLOCK_OPT_VALUE="--value"
>> +       else
>> +               export BTRFS_CORRUPT_BLOCK_OPT_VALUE="-v"
>> +       fi
>> +
>> +       $BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q "offset OFFSET"
>> +       if [ $? == 0 ]; then
>> +               export BTRFS_CORRUPT_BLOCK_OPT_OFFSET="--offset"
>> +       else
>> +               export BTRFS_CORRUPT_BLOCK_OPT_OFFSET="-o"
>> +       fi
>>   }
>>
>>   _require_btrfs_send_version()
>> diff --git a/common/verity b/common/verity
>> index 03d175ce1b7a..33a1c12f558e 100644
>> --- a/common/verity
>> +++ b/common/verity
>> @@ -400,9 +400,12 @@ _fsv_scratch_corrupt_merkle_tree()
>>                          local ascii=$(printf "%d" "'$byte'")
>>                          # This command will find a Merkle tree item for the inode (-I $ino,37,0)
>>                          # in the default filesystem tree (-r 5) and corrupt one byte (-b 1) at
>> -                       # $offset (-o $offset) with the ascii representation of the byte we read
>> -                       # (-v $ascii)
>> -                       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v $ascii -o $offset -b 1 $SCRATCH_DEV
>> +                       # $offset (-o|--offset $offset) with the ascii
>> +                       # representation of the byte we read (-v|--value $ascii)
>> +                       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
>> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE $ascii \
>> +                               $BTRFS_CORRUPT_BLOCK_OPT_OFFSET $offset \
>> +                                                       -b 1 $SCRATCH_DEV
>>                          (( offset += 1 ))
>>                  done
>>                  _scratch_mount
>> diff --git a/tests/btrfs/290 b/tests/btrfs/290
>> index 61e741faeb45..d6f777776838 100755
>> --- a/tests/btrfs/290
>> +++ b/tests/btrfs/290
>> @@ -58,7 +58,7 @@ corrupt_inline() {
>>          _scratch_unmount
>>          # inline data starts at disk_bytenr
>>          # overwrite the first u64 with random bogus junk
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV > /dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f disk_bytenr $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -72,7 +72,8 @@ corrupt_prealloc_to_reg() {
>>          _scratch_unmount
>>          # ensure non-zero at the pre-allocated region on disk
>>          # set extent type from prealloc (2) to reg (1)
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 1 $SCRATCH_DEV >/dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
>> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 1 $SCRATCH_DEV
>>          _scratch_mount
>>          # now that it's a regular file, reading actually looks at the previously
>>          # preallocated region, so ensure that has non-zero contents.
>> @@ -88,7 +89,8 @@ corrupt_reg_to_prealloc() {
>>          _fsv_enable $f
>>          _scratch_unmount
>>          # set type from reg (1) to prealloc (2)
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type -v 2 $SCRATCH_DEV >/dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 0 -f type \
>> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 2 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -104,7 +106,8 @@ corrupt_punch_hole() {
>>          _fsv_enable $f
>>          _scratch_unmount
>>          # change disk_bytenr to 0, representing a hole
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 0 $SCRATCH_DEV > /dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
>> +                               $BTRFS_CORRUPT_BLOCK_OPT_VALUE 0 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -118,7 +121,8 @@ corrupt_plug_hole() {
>>          _fsv_enable $f
>>          _scratch_unmount
>>          # change disk_bytenr to some value, plugging the hole
>> -       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr -v 13639680 $SCRATCH_DEV > /dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
>> +                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 13639680 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -132,7 +136,11 @@ corrupt_verity_descriptor() {
>>          _scratch_unmount
>>          # key for the descriptor item is <inode, BTRFS_VERITY_DESC_ITEM_KEY, 1>,
>>          # 88 is X. So we write 5 Xs to the start of the descriptor
>> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 0 -b 5 $SCRATCH_DEV > /dev/null 2>&1
>> +       btrfs in dump-tree -t 5 $SCRATCH_DEV > $tmp.desc_dump_tree
>> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 0 \
>> +                                       -b 5 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -144,7 +152,10 @@ corrupt_root_hash() {
>>          local ino=$(get_ino $f)
>>          _fsv_enable $f
>>          _scratch_unmount
>> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 -v 88 -o 16 -b 1 $SCRATCH_DEV > /dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,36,1 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 16 \
>> +                                       -b 1 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> @@ -159,7 +170,10 @@ corrupt_merkle_tree() {
>>          # key for the descriptor item is <inode, BTRFS_VERITY_MERKLE_ITEM_KEY, 0>,
>>          # 88 is X. So we write 5 Xs to somewhere in the middle of the first
>>          # merkle item
>> -       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 -v 88 -o 100 -b 5 $SCRATCH_DEV > /dev/null 2>&1
>> +       $BTRFS_CORRUPT_BLOCK_PROG -r 5 -I $ino,37,0 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_VALUE 88 \
>> +                                       $BTRFS_CORRUPT_BLOCK_OPT_OFFSET 100 \
>> +                                       -b 5 $SCRATCH_DEV
>>          _scratch_mount
>>          validate $f
>>   }
>> --
>> 2.39.3
>>
>>


