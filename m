Return-Path: <linux-btrfs+bounces-2073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F9847097
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9ACD1F2CE62
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1840A185B;
	Fri,  2 Feb 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mHLyy8wz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LBt/QLzM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA61E17F6
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877950; cv=fail; b=gUpWW2gk19gI6johACyH8gLSkAyjZbUEKukKF7MtZH0tjfH6hlZCcdqffwqRciEjUOv31TPvYAGFWaYgu2nVJ55bxm7YDj05qkbNuVhFooXUayH8SBz8XXp1BHWcKJNkolcNaEBWYqfZJbd1v/dhPBivLJpm5cGKXnuO223PCm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877950; c=relaxed/simple;
	bh=W1uNyvaGLgePZLrGfvCHuA4ySLAKvtm6XISunUFugHA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aI+89Rk+wBa+CxTKkP+iPOw5OzH5CgsFNfoZiUQe+r/ddXne6PavjO+/9VB2xX1wS/DRYTu9AL5WQDBP4ZnRgmGghfsCfkGHpIeSh6AA/YIAAOAFldFt0oxrPJhAvdeHrD0PJCJmTALTJkcdpY3T5Rn4uxs1DW0Jl1E0GQgMBO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mHLyy8wz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LBt/QLzM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128SxAq006583;
	Fri, 2 Feb 2024 12:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+kbeMoSr+DP3FGJmWw9TdBW725FZAPo+Te8Jrrf2Ht0=;
 b=mHLyy8wzkycRxaQF7j9XCM/fEolVnzLQug4xqWkI7kvKoGK8F9ajXiiUB6Xr3cRAF/z5
 Vi067mXtDt8Zz3rs6t3Kq+6xy4NadS8D+F4gaqKcuL9wIVq4vcOmBLzwqOzV+xkQgYz6
 DDLPTsURg9UarudHdp5QsygrjUYLGqCBvLFc6RoTq3pkWm+qCftbwv8MmwLsDRaWMdV6
 jNbcGFXgGDFEhCv/09/EimOMhpnc9uQVVTPqfddAm+UvNgSonutA7ffhwXzfZIvM5aKe
 jo4cW1kDciwErsZ+QViImJZcO3X9+YJdpYGVFnmf18TYgpEDyVfRNGu1nKadiX+r/tKC vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuqc9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 12:45:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BTlF4019694;
	Fri, 2 Feb 2024 12:45:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9hvqs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 12:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEcG7Z/jklxMsaXMT720ed/mYBX7GM3fYABNTeftp72yIk1p0F9PBcRXBYni36QZGqZs5fa5wzeo8PAWF/eCGWGwyJh2VJY3AFLA7Pdo+/IUvnRJJJey8GmzdZ7sqmr0fk7Z82NEW88izRpnDf2hyTUvfx1Vmgw12PAOZNwL7Zxxe8s02dfvdIsT5YZJaWWxAQ4ApP0LmtffJ1RRDZ0kgk+fhsE2P88HpGDY7oBLetGLna7cCQgDTkiHY2PiJfOj3/qHF3f5KFYbVmZT4cPQj3/a7lC4qfq3+kAOqAA8iyl4012VRxTKwBPt0QPSpQ9UugR3YH+sYtDEaEvJia86ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kbeMoSr+DP3FGJmWw9TdBW725FZAPo+Te8Jrrf2Ht0=;
 b=Pd/jV1FSl5ex1b1bmcMjG/SBjUAEQG018VyzDfrcmj/fsRpD//WnuZZZMURgHbaHMTZ//MdQkTt4Ifx1klQw/otCNLlzMGaRd3fcP8+tnRt+FN1JyS/ZIPp72awdbfewsp6Y596Ss6R1xc50JB5BC0g74pussPSYnYfrbNG/t41WBlyr1xPAj4mC3cYknKZL6fydiA02nK++jZBrlTt/lqL46+bKcxQ5YqKtObsp5IjBr7n4jaLK5NW3+DwwzxyWNDHZFNbqy1Ppv9fil46vaK4lUvVFOLv9q/Y3adLLYivH7/yPDilVrhq2CRshgNIpuH4W4OOr33+tfRZpKZMp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kbeMoSr+DP3FGJmWw9TdBW725FZAPo+Te8Jrrf2Ht0=;
 b=LBt/QLzMpvkvn76/ppvlRtP5d81b4M/ogVIYVHluk0Rh3DG7tr42lBOXtyX20UkKwv6wUMfVG/6j7gJXG+bcNq7nt3QIZ4SND8ROd3zdyKsQNqcXkhDEmJEM5JxxvXbLGqwG8ls2PK5t8idQSpoO3yvJJ0br78sBmR3fuSl+yJ4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4775.namprd10.prod.outlook.com (2603:10b6:510:38::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 12:45:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Fri, 2 Feb 2024
 12:45:42 +0000
Message-ID: <63d162a7-f7f2-4c04-a2e0-21c4ce6c8403@oracle.com>
Date: Fri, 2 Feb 2024 18:15:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5 v2] Struct to fs_info helpers
Content-Language: en-US
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1706810422.git.dsterba@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cover.1706810422.git.dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4775:EE_
X-MS-Office365-Filtering-Correlation-Id: d727c8ae-01ca-416d-72f4-08dc23ecde09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tHl+cnyUWpIimMStXGb8Yc+UkjFMarYqo5utTtWRwD/5Uf91T7vyglmpuMiEKbOD2w7X0vu+L52Py6l8UOxoz1FuAyCca66N+jnasDXL9fEobhIW9spxhquSabesYOsGopeE6dqnWPCnq3awTLVy3U8avfsQUj7d/0SAx5QVWKzt2CbGJLetUFxfJtr8IgHaloELKASGWil6XwAAAi0R7uJ0Ym4C2Me/puXJ/Pt8bPHRy8Kq/t2SAo5JMcEU7fcJ8i9hRuaF1zxEbX7VSE+Bs/LmfDuguRQ7K4OWNAtre2qhrS2QPky6XWzdlvRH+IW4L4CpQarZPY20hLb9e6PTZcFvBaf2XVYKceblxJIzu0HMQsxfyARKL0JqQ56CSeFlSkIWsXul11jD/kKGDZC/YdWCPDKPnXtzEJ9aYAW0kOZBqZTwGtig2rRNjhxVew/elxF1YGlv7TTjwHIjCf9VYcMCI689eCd8kCnTUC8iL9FyS5DZlw6qM2a6RYbvSm/Hf+V09SvPqgi9zlclnSXm9tj6sYYWFIj//qip6IMM2gSPX8CP5AKwyViJmVHvezeSh6LwPkxRIREEFRv+pXe/QFndDHQKbmjyDcn7LyL4AmtRyC+zTmCfiIbdK5ECo+RNio53udAcdKq/SapqBOeYgA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(31686004)(8676002)(6666004)(8936002)(316002)(6506007)(38100700002)(2906002)(4744005)(6512007)(31696002)(86362001)(44832011)(6486002)(478600001)(26005)(5660300002)(2616005)(66946007)(66476007)(66556008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0I1QnU1bDh2N0NKVlBvL1VBTmYwYUFJQlg3OUx5RmFPc0Jpd1g3N28rUmtS?=
 =?utf-8?B?U0RKNDJQS2pvZjVaOFFHb2haZ2VacS9lNmxDWldDRjJQWm1RSDV3dVhjWEU5?=
 =?utf-8?B?SkQ5d0p6b2Z1bjVYOTZzUGxoc2JrSkllUXdKYjFiUHplQUZkWDNHUUZwbEZK?=
 =?utf-8?B?UUpLdEZqcmJoaGY3Tkp1NGtUaERNOXBBVWtnNUI4ZVY5eG5xRUltbkR3aEl2?=
 =?utf-8?B?UTBrMWltV2o0ZkprU0RjT0lwdWsvT1Y3eXQ3Q3NFbC9tUEdlTGI5bHNCVzgr?=
 =?utf-8?B?SlNnUVFRKzBpZGt1VXhLSTRKWnVaemNuQllyWmowaXN1MTI2Qit6SHNVRkQ2?=
 =?utf-8?B?NmFPWDZhbVl3aEUzK0Vmc0pjbk5pSXc2YXp1a3dsWnBvWFZ4YmdsalM5YVdX?=
 =?utf-8?B?Um55TEJLSGx2YjMwVDFYaWF6NVpBT2RqMFpWNFE0NjN4TnJLTTVYa0t1RXBn?=
 =?utf-8?B?eUxxUUdRaFUrVXhQUzdqMGhBeGZVWFpiQzJKakdkclRRWHk4NC9CVVZub1ZP?=
 =?utf-8?B?NVorTU14bjhTb3hvMDJnWk5pWTd3UW91Z0lJVzdJaFpuU1FGZEtmMFBja2RE?=
 =?utf-8?B?NUpLalhxU29VSFVmNTdybmVURGVPYlZPcGg1Um53L0gyeFNqd3cvOTZzNjJI?=
 =?utf-8?B?ZmxOKy9CcmxDRDBlWldFRkd2VC8yVVZQa1ZTaGdDNFUxWGZFSGsxRWVqWjBo?=
 =?utf-8?B?ZDdlbUJJalN0cDJjMFlTQ1lkR3RyR2JHeUljUmRpUi9nL1ptUENjRTJLSVo2?=
 =?utf-8?B?emt1b2tGeEcweFlwQVdCSWZTK1dYVFZwdVFKUnR6NWpXOTBKZDZsN3lFY0tM?=
 =?utf-8?B?K05GYkNtSlJjSEFVV0xmVG92U1kxaEtsbll6Q0xmMFkrYXdnTXkwM0txaEdo?=
 =?utf-8?B?dmFhdGhoTVhqVktIdTloTW5sQUcxUU1VeVN5SXFaSDM3enF6WmtlQWtUN1lp?=
 =?utf-8?B?cVIvd2lDMlMrWlM2RVRkRDFUSzd0dHVnVjVWYk8zSHZWUUM3ZThLZDNtVjhG?=
 =?utf-8?B?VEVaR3Nrd2pPY3ZCNnBUS2hrYmt1T2ZOUmE5YjdYSVU5bCtRMDcrWDNXQnpv?=
 =?utf-8?B?RU9FVzVjR3ZhbGVmQWwyelZ3SkNPd2liOHNSYUxIYndQd0ZLa3BxSWtXdi9t?=
 =?utf-8?B?bTlFL2VyUzRCSmZLbVVxSFVqRW1ZcnZpd1RWcUJ3VWlBQUowWU5MMzFselVo?=
 =?utf-8?B?ZnJxTUo2RlBkTkhGUU5DdmwrbjU2eU9LZXVoSG4rbzNxbkJaYVNHL0J1THlH?=
 =?utf-8?B?MTdZR0VxVWhpTGRUY2dKRm9wdUdXUktocWZWQkhzd2RBQkhiN0J4Tk5OL21H?=
 =?utf-8?B?c0NiV3hrRTRMWjFwOEpSdnhpaW5pRkl4cEVaNmpXZDNaNWtKeGYzcXRwTGF2?=
 =?utf-8?B?TUFBWlQwdXkvT2tZcHdyQXEwRU9YMzBISkpVR0JRUFJERTFiWWNKYVVaQnI4?=
 =?utf-8?B?SmlzalMvWDZibm5RQjBhUU1aeWlyZnMwZVU1YlZGZjBIUzEzRG5BTUpJY0lK?=
 =?utf-8?B?b21kMkdvKzFMeG1nSFNpbmU1Y3dqbmZjZGFKMkNJa0s3c21aMVBrbENHZ1Bl?=
 =?utf-8?B?RkRHRUtRa0JpTUwrMmxrLzd0bW5XcUNnWGFrNWhiaVJlVms4Wkk3OE1IZEtK?=
 =?utf-8?B?eTFHYlFwVTBGaDc0TWlvWUZDcTMyTG1Kcld0bkk1NUxLbGVNRWljaGVpdk9u?=
 =?utf-8?B?TXd3M3NRdWdEMGpvV3dlTDIvd2JuaGFZQXFhNHRtQk8xY2xEeUZ3Qkw4aG9y?=
 =?utf-8?B?QzBDLys1VmhjajVOSFZEaWFZQnVwK3dnWjlyUWNkelZXSDNYUXorVmlBVlNJ?=
 =?utf-8?B?Wms4MTVrc3h2cCtVYXZxMnphUkkyazJZM3BneFJGamhoMEQyWE1wbmFVaW5o?=
 =?utf-8?B?cWo3OEZ1MGZESEJyaXhWRWN4QmZ2cGs0T09GQnZDMjNpK0s3c3RuTlY4Q1A0?=
 =?utf-8?B?TGp0a0V1akVRTHlBczI4eUs4OCtOMnZabEpqWVhDMFErdkI0OU5LY1psQUNR?=
 =?utf-8?B?K2FXQ25ZTE9BOStEUGp4dkVZQlpFU0VETUV1Vm16WmNpMlBuWXR3Y0NFZGtu?=
 =?utf-8?B?a1JrMWJLU2ZqakJiSE5HQXhya0lKV2JYTnF6YnVESXU1bHBmdUZmVk8vWkFl?=
 =?utf-8?Q?O00O/jkOV09j3zDnPUuzaq/lt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bEXolaVEQaK0Ivwmtkz3W4wCDLyC4on8hi6rPlPuHQ09POq8avs3CWsjCCaD9tcFaxfWT9XoqTsPk7erkg5dpGy1h6ICNpQhA4dVoZNh8i46XE0Zxzd+3WSed8PA+RUPR5KjGFuBSzK/ottaZrY4G48izxSXStl1Oz9QiBwz70hVIVleZCMXOjTaIoG766RAycD+zeKySGyGOIgRbFINwPi4JFpQKqccvmi9/FCv8ErkQdn6Wi2EfBUy8qKXP+hrqT5SWJUlHhm9h38zySVT6ilqv4kvkDilNXwcXu7D7MybDTd3R/swHvccx0fgJ04uogmo4CSHgLIvudl44gFhCDMa4iUv/GpFIyP1oEVuwbW8VSuuVIhVWTdWxKem2h0ZDYEX1qxaxxTMk+MUnM2C1MjS6xaUflK+1G9vHzDWThIUcuhI6JosJtniprHX3y7QXm+VpcRBC2noAr/a8zNro1Gw+1kUsmkLLLbTcwZ7js+ND3E307Ux6KfMfn2TcVegElqQP76/C1j3zbuloJg6pOtTJjWmOLUPnfiz1+SJngCxWFtkWSYYirJClr1ypwp3H4/5uAcA1BsHtpc48JvjplRBgTNvR2Zt8E5AFLiInDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d727c8ae-01ca-416d-72f4-08dc23ecde09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 12:45:42.8784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8Aa1fPyLPVmeHYOajF5pft8ESQGSAS2pbwnpsykAbnnkTu/jFM2Mad5nD+X7N7acpfeHByITzefAFNjRG0e9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020093
X-Proofpoint-ORIG-GUID: xpEAEOrXqSrhpn26j2iH2F7vqF37IueY
X-Proofpoint-GUID: xpEAEOrXqSrhpn26j2iH2F7vqF37IueY



>    btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()
>    btrfs: add helpers to get inode from page/folio pointers
>    btrfs: add helpers to get fs_info from page/folio pointers
>    btrfs: add helper to get fs_info from struct inode pointer
>    btrfs: hoist fs_info out of loops in end_bbio_data_write and
>      end_bbio_data_read


Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thx.

