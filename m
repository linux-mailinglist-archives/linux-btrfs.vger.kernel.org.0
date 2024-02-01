Return-Path: <linux-btrfs+bounces-1992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F19384556F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5603728C6D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1A15B970;
	Thu,  1 Feb 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hDg9ekwh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wNtNsx6V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61C15B969
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783603; cv=fail; b=WcxtsCak8SpIgCinXki++nooCai+M/8C+CnUdBqHDVakYL1EPD18sJ8E/PFohZLKrwZ+QWKzXo7tODQFYKlyfQo7Hg0f1hwnbPXDNICmg4I+MxTLix0XoUY3aEpfic03mrk5tyDzpxIICXOkz+lHYJFoe65mm/ObAplxv9FU0CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783603; c=relaxed/simple;
	bh=6PdLEmDX9NIQQ7ZkWRIUy4OOl/57hBrvcxpa5Z+L9M4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UWqLoqHuAa0+nD3avMTXzBa6fOGG1EMw9NaAuTSkpZ0h+Ue7UEIJizkPGiTF07pVPS1kpDPhTUXzveiX0gRp2WmvJU9/cjW8XhJHmb+b2dHXWQJHNNN0GrhDMSUrF+MmcWOGeahjKVAgZLp1UIjh2TPt1256Wh6dFf2hXK3fz0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hDg9ekwh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wNtNsx6V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4110wwNW026046;
	Thu, 1 Feb 2024 10:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=g0u4o+pWd4+buSwCfRdVH+EcttdqM9hdlqAUHe5CGWg=;
 b=hDg9ekwhPP8mESMG2xdwYVf/EYkZy6JNFJd/T5Kq+b0nRm3L+SEpus1VAAXhfmbaD+Cn
 XMTBhpjDAZiCspnwo8XUO47WmLAHBDr5xuLPciItQBJHww+pnIBNxG1fcnAWwxB8FHQV
 HuHGjGKLWpVPhhLTBR9EZk1n7mBRKeViW4uD28fMSR1lZf0LSnvL/ubNva99cs3BTWuS
 BsJl6mRFy7wfjlXzHW8ay9SJ8WkQp6o4rHwUd4y1A10h+XtXeszVbDp9euoB+hhlYVCa
 ChRePEvTDuTTjSGh60eZpEGmnDhROjLPrs8qyIKxRzPtZqNpBIOUg59mEMIi0/w2+LwW CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8em1n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 10:33:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4119P7WJ025854;
	Thu, 1 Feb 2024 10:33:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ahcba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 10:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWTwE0ROXA8nhtMGKV89kC9ZdncAMrV/8H0DIaVaFshutH4fgUfriaEeNf6Tf9yuXTxpQJc6I36NMTuFbWAQMWrmJUnXSt0bfWlwjHG2ozc8oIL7q8SjeR77VnkcCqbHfkK9xE8OY0qejdHVFkMPblsRMIfjHIs9XxCNDUnFOUBMZo1te58frTu2OtWoKKQYlSVYmQJZrRiJ0+Sl77aapLJ4NMRR3z9PonpIVIJOKiaiBhASnMRJvSFi4yWSeO4Lp9Zd5gm/SpHuMJ7L8Lkmfw46zNGBONn+c2m/Eu22ZXxzcgJwbT2NZYebqMkRXT1/kAYlkn+3yp72TbBSKyeg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0u4o+pWd4+buSwCfRdVH+EcttdqM9hdlqAUHe5CGWg=;
 b=TnT/N5KOS+0X8cslM2RTpZ+Jdr+P1XutptIRbHpnW4SaHpX6KEzuzqIDBP9Uw3xZkFpO+ZFarhTDSlG0piPZ0zY/2FtljB52nEXBvLVj/amMv7EuWpHkVEX2LTr3M9JdfHO5sb7mm699x1HuP61xG56LpOZtRqx5hEYQA/ZGu0kHawe8A+FIABhLrpOe16kMwMrP12vLcBuLdrm0x1NkHHS9F5NphSXtbKP4EJQ7ag3jT3rMgZ4GQexHyNpK7UfE7WGoKaOGo82xmykdz+OGEKAOwlU80qhFbmiLJr7Etyt82UHaxj7pUrj5AajjgG/vDcqfONfGfRJFWBOX+qRWhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0u4o+pWd4+buSwCfRdVH+EcttdqM9hdlqAUHe5CGWg=;
 b=wNtNsx6VQ9795DStZLxExpa1GWL/WPqYO4wGLL8lb+tbCKhQvHbOTNzq2lDm2Ei8brwUXMqBeccvjMngwo+lxz1MniIxQO/KhncDhWYikgUMLqkJ+golMDq2GjIY8X+3w+gn1B9T9FQwSZZ4QtgDDtZSx4vTvNTMZweKnLTeiVg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB7222.namprd10.prod.outlook.com (2603:10b6:8:f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 10:32:47 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 10:32:47 +0000
Message-ID: <868c62e2-9bf9-49ed-97e5-ddfdf1e138ed@oracle.com>
Date: Thu, 1 Feb 2024 16:02:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <b5b191e2-27a8-4d9f-92ec-434e7b88d1f9@oracle.com>
 <0f6bbeb1-0d05-4f4c-837d-11ca8297fcef@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0f6bbeb1-0d05-4f4c-837d-11ca8297fcef@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d39eee-2580-4259-c244-08dc231121c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gdGz60wkHxnHNFhs/d1Jp8vIZwLWE2eknsmy2+7IWOoHnZnNN4/gxdVabFzQ4glFgxxVt4Gwci3wILSnmsu/cROPdxgWieUoZARmR0vVAZQ30kbcl8MzW1i+oO4GRKBFlBZM3NPRe/HYODC5eN21so1UQ3gb9+R+ZKcGrmRQPBCOGeyJBSyab5UcxYI+BhFHV3ZJyyPy0ARhQaTFoYnBpKiWbfgTf2dokJPlRJ+R3cIyX6bDWGeiifQjQWn9nXfea6K2JpIleADQ8aEfUE75689x3rhoQyIMTzTgBaU/e7WQsTb7XxMU9bHVX/OnUMQmMCTjTaYknG7st1PKezKbtewgAcp0PodWwXtQjVBRuiFvQMAeVKWUx2n+r3aoMVhn6dZBQwJZMdqc+izit6dEQteYlN6SMkcoqkSttmH68Yi+ugBKiHzzyfTeRtD3SyRrgx9ZS3hsqWqPghaMYv5id/jBzYIhmSBXm/MczdqjjLk+gQIJCXTE+PRaDkf2bnTev3jZ+eCXqsYwuTu+9zBZ9sKV831fGVDRKhIZcsWF4F1Vio+JredcYY2/Z9H6W4xTSrqP1WFGGPyD7CjJfEOqpG1D85bsJLA9NM3Ad47s8scL5UajmLSOmaJ5UA9KZfv0G6RUXUgGh6W0bTVXvJftjUD+EAV2IbDOi8BB4VgmY3l0EKOJrfsYzOFMwh/tdYTApDEqhGgZhfcnuVjqpfrhBu8hjutsH1WdZQVFJvOm7Vo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(83380400001)(31696002)(36756003)(86362001)(6512007)(26005)(38100700002)(2616005)(30864003)(53546011)(6506007)(2906002)(6486002)(41300700001)(6666004)(66556008)(478600001)(316002)(66946007)(44832011)(8936002)(5660300002)(66476007)(8676002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czVsZGREUmdyNzZFa1lBQW9QVGhaNEhrOVBhM0NkNmdwY241S2FkU2NReG0x?=
 =?utf-8?B?REUwL0NpUzUzTEkvVHJMN2w2RzkydDNkOE1GaXc5eWNkZmdyc3pCUmIzRVY4?=
 =?utf-8?B?Z3IwdFVpcWs3bzNWc0dCNjMvK1RCOFZFL1dSZ0h4WWd6K1NUMUxOTEpVZmM2?=
 =?utf-8?B?M1VQOTg3MklqdWJ1MnV5WVp6M3FpQ3FIM0xyYkdOcWw3cmN0ZnJBR1kzdEc1?=
 =?utf-8?B?TEZvbzlrdDlSbGhBRnd5TE1IZmxJQ2FBTDJBMktkSlRHbjNWVXc0b1JtbmVW?=
 =?utf-8?B?c1lHeGhHb3RSbThsWmdWRTV6cmJhaVdsRzREVFFDN3NsdVR5RzJnZkhWUWNG?=
 =?utf-8?B?eEU5V2RwaG11Y3hFRUFjenQ2a3A5elVId3N0UkdLYnoraHR1RDJMcHEva29U?=
 =?utf-8?B?czl5eFAyMjR2bTdqK2wxUDV3UWM0bFl2Y2VjcHNCY2NtWDYzQWZla09aYmFD?=
 =?utf-8?B?NE1JdTZnRjlTS1FhR2k4ZFU4RmlRUG9NMTBuOTZrcGdIRDUveWJPUFU2ZFVy?=
 =?utf-8?B?eG9CclY5dURGN3hlVWlGdFFqclNaK3VGZ0NkWE5ydlJOMU52RnFvL2VoV3BS?=
 =?utf-8?B?UWlzdW5qM2V6TldVdUx1RjlNSTA0VTZ2UEhORk5IY25FV0s0WVoxWUlhWDYw?=
 =?utf-8?B?aXVnNFNQektiRU1HVVltall6V1N6eUFuYXlNb2FsdWYwcUhQUWdjODl0dGFW?=
 =?utf-8?B?cjJtMmIybG5GWmRlZE1JbmpZYTdGZnViQnlUT3BlTlRIOWdmQ01SV0JzTEtE?=
 =?utf-8?B?aTBHeEN0dGYrMnNpaVoxaTZOVEJoRE05Vk1xd2hydCtGZHhPY0Jpc05VbXE1?=
 =?utf-8?B?OGFiUzVVQXBydWtyVUtmK1JrY3JqSE0wR2lBaFJFUnBjcURZU1pXbDVYVTZN?=
 =?utf-8?B?RW5YeTI1ODl5T24wZ1F1dVJ4TFNzMUFoYXdId28rNGM0T3U5dEdtNkdqMGpn?=
 =?utf-8?B?L0srS3d2UzNqTHlqNXNvSXU3RGFiZ1pJSlZENjdFWkcwbjYrSXBxM1RsSGg5?=
 =?utf-8?B?WEU4eHd1TzZXK2szTTNsaWFUaS9CeHZ4WUQzRkY0NjR6cEIxYjJHdnI3U2ZN?=
 =?utf-8?B?NnhrN2lISTlEMlYxeGNoejEzUXBDamtGUE5LRDhUYSthR0dRbWFiR0E0bUtC?=
 =?utf-8?B?M1NNTjhHY3BMRFUvSkYzcTVEZFAvdmRhUURodXVBYWdUdyt1Y1VDSG5pV3B5?=
 =?utf-8?B?M255K1dlWFUzeW84eUxLdTUySUhNZkxHUU1SNWRvVHI2dTRpQ2NiMk5OODF1?=
 =?utf-8?B?VERjelpLV2hyUEw3anQzb2tiSXhOTnJkVFlQNXYyaGNVTTdsRTFFMVExblNI?=
 =?utf-8?B?R2RpWFd5NXhseFlhK2o5TzVUbTRyUFkrUlp1aTA2Nk9uRHRzY2thWDYraURo?=
 =?utf-8?B?S3RVNUJjaHk5N3o1bzJRTEdwT2JjbC9KTUNUdGh1d2E0RkF3MmdEUjhZTWlX?=
 =?utf-8?B?cXhqOExiTUswdW8ra0phNnFsZXNrYlNFUXkreTA3OUY0ZFZDSUI3ZFh6QmFV?=
 =?utf-8?B?VEhhQ3V4TmhXd2d2bWxEU1lxOW02TjRPZmZEL2M2eW9kL0pyVVZ6bndJdjUv?=
 =?utf-8?B?Ly9BUmo0d3B3eUdrcytUS3h6ZnA5VUREWitnYk1RZW95NDREUHBWRDk4Q3hL?=
 =?utf-8?B?bEhZc1dFa3lpYmVCakRhOFFKczNrYjNxUFQ0ajNtbFNBd2FKT2lJTDVFdmNZ?=
 =?utf-8?B?S0tUYlYxTWozUGpHemZXYWdRSDNrQjVTQUVidklXM2NDaU83U2NVZFFaWkpV?=
 =?utf-8?B?VFlZSWF1Qkk2blc0MVFURnZLdjlnNVVTYUZ5TzA5SzAwWlMxQ3dlN3NpcFNu?=
 =?utf-8?B?ZUorNW1wVmUwUlJlWlV5eEhwVS8rTW5yRFpFWnBnM0YwcGJVcStRNXMrQ1VU?=
 =?utf-8?B?dXhkM05jekp5TWk3RHNOSkZiTTI5MkhBV2NRYWFybkxaK0ZOZi9YSVM0ZHFO?=
 =?utf-8?B?TGxJN05PaHc0VTlEZ25NU1RTVWpWc3BqdGpUSjEwZXJQZUIxWGovSkdWSWx4?=
 =?utf-8?B?TnY1azFIZkFVN0pucFJMWW1mL0IwMUNJeTU5L0lYaGJERDI1YWY2anZ3bUlP?=
 =?utf-8?B?SmFGU2cvYXgydGRxVTVwRHYzbXdJTWhWMVVUSE9OcmZaZS9yUUlVTHBWQ2lC?=
 =?utf-8?Q?I5VlY9JjpdsrIeKaDQb4PMiUz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PF+M+QzYrbi6R9gQ+6TwQtweVXDXeERRJ9DNjDwnsVuBHAYuSqw3LVElei+1tnmiKZhGE6hz5XM1FZfMeIMFoOtO195UxH9y4i9HU3sqPpqMuQv7Z8yNLs3FEaSGFGUy7E7RxGEAXs9wuVCnqPIwhnmM6eiMl5oFu2NUiFjEi+jMg0RYiQdj+a0Y/PsgiP28ytrB6PVUsYrnoBhbr0dolSodG44MEqwuI4jtL7JhKaxOpb8jZfV6qb0i0SHT9VMkKe3CtnlBo0Wm3PVyCcBO6VFNdvReBehrDoJhgozbiPUG97At0VAVJQIhpL9511KPYJx9ap6P8nXoc3IMREa64y+Sg2YJU3fVwfHiFLcwZLve+D6r737ALgNWUBP0E+xhLWzUHHjs30VVDkSnkT08AeQO1Su1KAmJcl86bE417ACnJ2dXAoaniAnGviD3uOEWkzpD6J5GxlUsD/QhMtF1AvszLIFHXm8AyLQFGsrFGK1sLmUsNdIo37dnFcfjGGF5VA46C3rS4giOzWCV0iByDiB7VImjd06fr4oanZiYnmzrQLsyTf1uPeWMxuVt2i4vtJfQ/PydpzNrVQitO+CSkdem/CLa9KA/Wa6GcJrq6AE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d39eee-2580-4259-c244-08dc231121c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 10:32:47.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZJctRoyYi4VjJQ21YlKntNkYSpJXpOyspBkh7UzLp3tixbdUnf9VKnprqRYTlFOiypDFT8yRUoVn5r6TYitqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010085
X-Proofpoint-ORIG-GUID: -lc13YhcOg_de_TbSyLC4RTV6vvcFu9t
X-Proofpoint-GUID: -lc13YhcOg_de_TbSyLC4RTV6vvcFu9t



On 2/1/24 04:06, Qu Wenruo wrote:
> 
> 
> On 2024/2/1 02:23, Anand Jain wrote:
>> On 1/30/24 11:31, Qu Wenruo wrote:
>>> [BUG]
>>> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
>>> descriptors open during whole time"), there is still a bug report about
>>> blkid failed to grab the FSID:
>>>
>>>   device=/dev/loop0
>>>   fstype=btrfs
>>>
>>>   wipefs -a "$device"*
>>>
>>>   parted -s "$device" \
>>>       mklabel gpt \
>>>       mkpart '"EFI system partition"' fat32 1MiB 513MiB \
>>>       set 1 esp on \
>>>       mkpart '"root partition"' "$fstype" 513MiB 100%
>>>
>>>   udevadm settle
>>>   partitions=($(lsblk -n -o path "$device"))
>>>
>>>   mkfs.fat -F 32 ${partitions[1]}
>>>   mkfs."$fstype" ${partitions[2]}
>>>   udevadm settle
>>>
>>> The above script can sometimes result empty fsid:
>>>
>>>   loop0
>>>   |-loop0p1 BDF3-552B
>>>   `-loop0p2
>>>
>>
>>
>>
>>> [CAUSE]
>>> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
>>> open during whole time") changed the lifespan of the fds, it doesn't
>>> properly inform udev about our change to certain partition.
>>>


>>> Thus for a multi-partition case, udev can start scanning the whole disk,
>>> meanwhile our mkfs is still happening halfway.
>>>
>>> If the scan is done before our new super blocks written, and our close()
>>> calls happens later just before the current scan is finished, udev can
>>> got the temporary super blocks (which is not a valid one).
>>>
>>> And since our close() calls happens during the scan, there would be no
>>> new scan, thus leading to the bad result.
>>>
>>
>>
>>
>> I am able to reproduce the missing udev events without the device 
>> partitions on the entire device also, so its not about the flock.
>> Also, per the udevadm monitor I see no new fsid being reported for the 
>> btrfs. Please find the test case in the RFC patch below.
> 
> Please go check the issue of btrfs-progs.
> 
> Firstly, it is about flock().
> In fact the problem would be gone if using "udevadm lock" command for 
> the mkfs.btrfs.
> 
> And as I already explained, "udevadm lock" is just flock() for the 
> parent block device, with some extra fancy work like deadline and 
> deduplication.
> 

I am able to reproduce the issue on the entire device, which conflicts
with the cause you have mentioned. Ref to the test case in the RFC.

>> The problem appears to be a convoluted nested file descriptor of the 
>> primary device (which obtains the temp-super-block).
> 
> Nope.

I don't see how your fix will work when two filesystems' mkfs use
flock() simultaneously on different partitions of the same device.
IMO, this approach is incorrect.

Were you able reproduce the issue with mkfs.xfs? I couldn't; xfs
doesn't use flock() either, as I glanced.

Cleaning up the mkfs.btrfs file descriptors has been pending for a
long time, which my RFC patch did as a first step. It makes it
similar to what other filesystem mkfs do, with no nesting of open
and close per device. The udev monitors CLOSE-WRITE event, and it
works well with this RFC.

Thanks, Anand

> 
> Thanks,
> Qu
> 
>>
>> The RFC patch below optimizes the file descriptors and I find it to 
>> fix the issue. Now, both yours and my test cases pass.
>>
>> [PATCH RFC] btrfs-progs: mkfs: optimize file descriptor usage in
>>   mkfs.btrfs
>>
>> Thanks, Anand
>>
>>
>>
>>
>>> [FIX]
>>> The proper way to avoid race with udev is to flock() the whole disk
>>> (aka, the parent block device, not the partition disk).
>>>
>>> Thus this patch would introduce such mechanism by:
>>>
>>> - btrfs_flock_one_device()
>>>    This would resolve the path to a whole disk path.
>>>    Then make sure the whole disk is not already locked (this can happen
>>>    for cases like "mkfs.btrfs -f /dev/sda[123]").
>>>
>>>    If the device is not already locked, then flock() the device, and
>>>    insert a new entry into the list.
>>>
>>> - btrfs_unlock_all_devices()
>>>    Would go unlock all devices recorded in locked_devices list, and free
>>>    the memory.
>>>
>>> And mkfs.btrfs would be the first one to utilize the new mechanism, to
>>> prevent such race with udev.
>>>
>>> Issue: #734
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Fix the patch prefix
>>>    From "btrfs" to "btrfs-progs"
>>> ---
>>>   common/device-utils.c | 114 ++++++++++++++++++++++++++++++++++++++++++
>>>   common/device-utils.h |   3 ++
>>>   mkfs/main.c           |  11 ++++
>>>   3 files changed, 128 insertions(+)
>>>
>>> diff --git a/common/device-utils.c b/common/device-utils.c
>>> index f86120afa00c..88c21c66382d 100644
>>> --- a/common/device-utils.c
>>> +++ b/common/device-utils.c
>>> @@ -17,11 +17,13 @@
>>>   #include <sys/ioctl.h>
>>>   #include <sys/stat.h>
>>>   #include <sys/types.h>
>>> +#include <sys/file.h>
>>>   #include <linux/limits.h>
>>>   #ifdef BTRFS_ZONED
>>>   #include <linux/blkzoned.h>
>>>   #endif
>>>   #include <linux/fs.h>
>>> +#include <linux/kdev_t.h>
>>>   #include <limits.h>
>>>   #include <stdio.h>
>>>   #include <stdlib.h>
>>> @@ -48,6 +50,24 @@
>>>   #define BLKDISCARD    _IO(0x12,119)
>>>   #endif
>>>
>>> +static LIST_HEAD(locked_devices);
>>> +
>>> +/*
>>> + * This is to record flock()ed devices.
>>> + * For flock() to prevent udev races, we must lock the parent block 
>>> device,
>>> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that 
>>> case
>>> + * we should only lock "/dev/sda" once.
>>> + *
>>> + * This structure would be used to record any flocked block device (not
>>> + * the partition one), and avoid double locking.
>>> + */
>>> +struct btrfs_locked_wholedisk {
>>> +    char *full_path;
>>> +    dev_t devno;
>>> +    int fd;
>>> +    struct list_head list;
>>> +};
>>> +
>>>   /*
>>>    * Discard the given range in one go
>>>    */
>>> @@ -633,3 +653,97 @@ ssize_t btrfs_direct_pwrite(int fd, const void 
>>> *buf, size_t count, off_t offset)
>>>       free(bounce_buf);
>>>       return ret;
>>>   }
>>> +
>>> +int btrfs_flock_one_device(char *path)
>>> +{
>>> +    struct btrfs_locked_wholedisk *entry;
>>> +    struct stat st = { 0 };
>>> +    char *wholedisk_path;
>>> +    dev_t wholedisk_devno;
>>> +    int ret;
>>> +
>>> +    ret = stat(path, &st);
>>> +    if (ret < 0) {
>>> +        error("failed to stat %s: %m", path);
>>> +        return -errno;
>>> +    }
>>> +    /* Non-block device, skipping the locking. */
>>> +    if (!S_ISBLK(st.st_mode))
>>> +        return 0;
>>> +
>>> +    ret = blkid_devno_to_wholedisk(st.st_dev, path, strlen(path),
>>> +                       &wholedisk_devno);
>>> +    if (ret < 0) {
>>> +        error("failed to get the whole disk devno for %s: %m", path);
>>> +        return -errno;
>>> +    }
>>> +    wholedisk_path = blkid_devno_to_devname(wholedisk_devno);
>>> +    if (!wholedisk_path) {
>>> +        error("failed to get the devname of dev %ld:%ld",
>>> +            MAJOR(wholedisk_devno), MINOR(wholedisk_devno));
>>> +    }
>>> +
>>> +    /* Check if we already have the whole disk in the list. */
>>> +    list_for_each_entry(entry, &locked_devices, list) {
>>> +        /* The wholedisk is already locked, need to do nothing. */
>>> +        if (entry->devno == wholedisk_devno ||
>>> +            entry->full_path == wholedisk_path) {
>>> +            free(wholedisk_path);
>>> +            return 0;
>>> +        }
>>> +    }
>>> +
>>> +    /* Allocate new entry. */
>>> +    entry = malloc(sizeof(*entry));
>>> +    if (!entry) {
>>> +        errno = ENOMEM;
>>> +        error("unable to allocate new memory for %s: %m",
>>> +              wholedisk_path);
>>> +        free(wholedisk_path);
>>> +        return -errno;
>>> +    }
>>> +    entry->devno = wholedisk_devno;
>>> +    entry->full_path = wholedisk_path;
>>> +
>>> +    /* Lock the whole disk. */
>>> +    entry->fd = open(wholedisk_path, O_RDONLY);
>>> +    if (entry->fd < 0) {
>>> +        error("failed to open device %s: %m",
>>> +              wholedisk_path);
>>> +        free(wholedisk_path);
>>> +        free(entry);
>>> +        return -errno;
>>> +    }
>>> +    ret = flock(entry->fd, LOCK_EX);
>>> +    if (ret < 0) {
>>> +        error("failed to hold an exclusive lock on %s: %m",
>>> +              wholedisk_path);
>>> +        free(wholedisk_path);
>>> +        free(entry);
>>> +        return -errno;
>>> +    }
>>> +
>>> +    /* Insert it into the list. */
>>> +    list_add_tail(&entry->list, &locked_devices);
>>> +    return 0;
>>> +}
>>> +
>>> +void btrfs_unlock_all_devicecs(void)
>>> +{
>>> +    while (!list_empty(&locked_devices)) {
>>> +        struct btrfs_locked_wholedisk *entry;
>>> +        int ret;
>>> +
>>> +        entry = list_entry(locked_devices.next,
>>> +                   struct btrfs_locked_wholedisk, list);
>>> +
>>> +        list_del_init(&entry->list);
>>> +        ret = flock(entry->fd, LOCK_UN);
>>> +        if (ret < 0)
>>> +            warning("failed to unlock %s (fd %d dev %ld:%ld), 
>>> skipping it",
>>> +                entry->full_path, entry->fd, MAJOR(entry->devno),
>>> +                MINOR(entry->devno));
>>> +        free(entry->full_path);
>>> +        free(entry);
>>> +    }
>>> +}
>>> diff --git a/common/device-utils.h b/common/device-utils.h
>>> index 853d17b5ab98..3a04348a0867 100644
>>> --- a/common/device-utils.h
>>> +++ b/common/device-utils.h
>>> @@ -57,6 +57,9 @@ int btrfs_prepare_device(int fd, const char *file, 
>>> u64 *block_count_ret,
>>>   ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t 
>>> offset);
>>>   ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, 
>>> off_t offset);
>>>
>>> +int btrfs_flock_one_device(char *path);
>>> +void btrfs_unlock_all_devicecs(void);
>>> +
>>>   #ifdef BTRFS_ZONED
>>>   static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t 
>>> count,
>>>                      off_t offset, bool direct)
>>> diff --git a/mkfs/main.c b/mkfs/main.c
>>> index b9882208dbd5..6e6cb81a4165 100644
>>> --- a/mkfs/main.c
>>> +++ b/mkfs/main.c
>>> @@ -1723,6 +1723,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>>           }
>>>       }
>>>
>>> +    /* Lock all devices to prevent race with udev probing. */
>>> +    for (i = 0; i < device_count; i++) {
>>> +        char *path = argv[optind + i - 1];
>>> +
>>> +        ret = btrfs_flock_one_device(path);
>>> +        if (ret < 0)
>>> +            warning("failed to flock %s, skipping it", path);
>>> +    }
>>> +
>>>       /* Start threads */
>>>       for (i = 0; i < device_count; i++) {
>>>           prepare_ctx[i].file = argv[optind + i - 1];
>>> @@ -2079,6 +2088,7 @@ out:
>>>       free(label);
>>>       free(source_dir);
>>>
>>> +    btrfs_unlock_all_devicecs();
>>>       return !!ret;
>>>
>>>   error:
>>> @@ -2090,6 +2100,7 @@ error:
>>>       free(prepare_ctx);
>>>       free(label);
>>>       free(source_dir);
>>> +    btrfs_unlock_all_devicecs();
>>>       exit(1);
>>>   success:
>>>       exit(0);
>>> -- 
>>> 2.43.0
>>>
>>

