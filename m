Return-Path: <linux-btrfs+bounces-13424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB4A9CCC7
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 17:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F81BC353D
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647A279346;
	Fri, 25 Apr 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SQKc444c";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D343nb5F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DC24C08D;
	Fri, 25 Apr 2025 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594633; cv=fail; b=eyHOOfirQn6HlHX39owPUJUYNhfKvz3AQxOi5XxZdE7G462iMoqV4+TkklKUU71P3voq50ayW1zp8VoksxIQ41U2NLikbeqjTesAeOSx2zjrdUD45FaR1X574zv/LSxdMMnRcIop70zrcPiIO36vXi+GsxNuKwYik0k3+Hj5ZN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594633; c=relaxed/simple;
	bh=hiFVALDK9tmax9qXHICA+QgW/VM9VXSVJvuSTnrWGUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bGzdSBPz3CyBCkCe/V4N2aW7wBupbNNd7lLux15nZ4pon9o7H8u0lYewD6XFsCRLTfDFBJ7G5Sdz4vP1+Zx6DP7KXQR/g+C51PZG/aLvKUTGpvL1NDB7WoB/OhS09ETb1Ga9CGVnCD3QXxJfEmK2dblQ+g7/W0OykxHTvWxpFAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SQKc444c; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D343nb5F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtp0j026464;
	Fri, 25 Apr 2025 15:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LU/tHBkLdBTDgRmXNooK8Gc/ckwSv38StchN/vGDXnQ=; b=
	SQKc444c/r1JoyLi7rSFHvmPlWPCBNK8DL7wjTqbdzNeCn/Ms99TI/sblb+SPUst
	lbLX9KnqAaAA5FQd6WkwDr4FR/zM5B6sXgdECWb+pDVRuJ3X8jevlEnYPiShwql9
	Nyc9T90KpCuHp9tR31CnWefaMpPmpoVVuq5hjmMWamlHVKXbcNEctkaK0exAFIUh
	hrj7Cvu+raD72PUtSRdIv1udcsFkfTr/A1vAb1bR/FQ5Vy6YHFvGXNj1fw5X17em
	hvl/rkqAtInk1SoVWdSEK8SGWkHAKweSGC0IBt0cEFDIY1rSl+HowO/A8OS44U+7
	L9MFPvYQAq2g97CZDK52EA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468bs189dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:23:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEqNGe014159;
	Fri, 25 Apr 2025 15:23:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrsc2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:23:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FTE+7DnZZ5WhdTp0/4tqrTvhtROLppCcxbtC6YthpnCYN3DPYXhwbiBGKiSga69hiJs8ZeGUVjUX6xyxz2nmBJtyEkN6ks/Z2Bwk01PZq9BZwxEZsQZwcDIl//r6eUB/mbmP6Di9NQ4H5OlrR2YroSrAxFl08LEocovKBJl2aMfzWQHYWQesA88RmHbpeYKJiKt0+yobux7gms8nKWiSbZDqjQZxym4wCjAk0GoLs1k8v8bke2ozHezXmVwkKaGwLe6DLD8yMADT71wQL4ROLwZBJ8Af3SRmzpbCHVccXRA8nfKPnv0o+AmdSjkl1p9z020LzjBDl7bBkXZ58W52xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LU/tHBkLdBTDgRmXNooK8Gc/ckwSv38StchN/vGDXnQ=;
 b=xzs3ADx43o1nq7dR494QMMy/1WtYeovG49D6xZbKNqhoteI4vGf3aCTyuOs+hw6uIs/L57yqjgkBYq/Aw0ce+iIa08oY+i3LtRmDtLyYMaBrdpvXmwLIPvxyxjfbCFTccNOhB6eJrZ4X2CzpAKfhLklLs7VP139b/xUkYyGIMdidtU6oW5jHLmYWW5G+jckbPDCDctSlDF+H5WRXDugrjuDryYw9XHasJXc+xCOz9NYYajzzFffOJCLY3RN+YHG87tGHNPyIO+cW1o+CJQPiNaZLIeUHowN3hCm3Ue1Nf0gFV5mr+zJ4GONT0WwAptQ0xctM/NFBEOqCC6uBhvYY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LU/tHBkLdBTDgRmXNooK8Gc/ckwSv38StchN/vGDXnQ=;
 b=D343nb5Fa64+ON2GQQIy/uYohnwnODkhhTZuBRQeh6i4BOVWo9Pmloq0Rx6g5GFthrdy+rTTXV1mXaOa0tyEpMnQBBKLy5WJ2LwWUTcy97WiMzvWj9icf8gNxLelzss12taRJPpWvtDDyn9Vt9m7FouvqAMxoKzDZy0CO9zna2M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:23:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 15:23:45 +0000
Message-ID: <f4cbd10c-b291-4676-946f-1ceca981fbd5@oracle.com>
Date: Fri, 25 Apr 2025 20:53:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: common/btrfs: add _ prefix to temp fsid helper
 functions
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <6097a2fd8b587ccc5982106142421f472861e949.1744892813.git.anand.jain@oracle.com>
 <20250423142916.p55223lw7qgbz3iq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250423142916.p55223lw7qgbz3iq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c3e40a-cb6a-45c8-8e55-08dd840d2b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2ZlVGVEdW1rMExLSjR3ekNoc0pPa2FNbmVaajFWZ2NWTVQ1Yk1uL0MvTjJL?=
 =?utf-8?B?SFRPTTQ3N0NpeER5a3YvKzdVajV0NHJYL0Yybi9vRHVicmtrdG9TMTdsZGtX?=
 =?utf-8?B?ZEZScitBekllUWxTQjNHdWV0L2p6eUFLZnJvYmRiWW8wYjZHS01tWFJ1dGE0?=
 =?utf-8?B?b2Q3Qm9yTXlGakduR2FnMUpsdlNPaFhyQVJQYXcycWgydUl4R2dIMllBNkRw?=
 =?utf-8?B?dUh2N2JtYllXcENGWmdZMnhrNVVYTHdwYUlmcXRLdjgvWXY2NDFzMzliY2tZ?=
 =?utf-8?B?SlFOZURSaW1hVjFidEtGRmJuUnRxSFM0NnluL1l5bGM5S0pyYnRVMmlWeDFa?=
 =?utf-8?B?SVQvSmtVSU85TUhpaHc4U0hWNE5YWjNESDRGNVBxbWg5djJIUFpMRGxnbGlt?=
 =?utf-8?B?LzJPaUd2Z09Ub0krVHpySVpqOGhFWFRueGdnRGRPQW9yUHQ5MnVOeWpkZUtw?=
 =?utf-8?B?NEx1NHByUSsxUWVOcVUvNXF6elRtdE5BQkhnYWpQQ25waGhFQXJBWTRxN0tn?=
 =?utf-8?B?WmZmTGZNVGExWnZQa25HdmVrNVpPUkZQd3VqMURsUjRKa1hBdVJjMzd6RjZj?=
 =?utf-8?B?dWJtaFVQaVQyMEdvVGFGYVd2UmxGNHVPaThscFlMSW9FZ0lsaXVSa05YbDkz?=
 =?utf-8?B?UkZoSG4zVDh3RVF0a0lCdzRlRlNiZ0lCNUo0bEV1Y1MxRHVFOHlkZjVkTVJE?=
 =?utf-8?B?c0RpNHVsbWRNamNkMGp2dW94dGF1azFxNHIyK0NwMEY4Vm9aRFp0d1QxYlVY?=
 =?utf-8?B?K0JCOVBXYWhGZnNtZFpoQWN5cDgwZk01NnJhZEc5UUYwaXZTUWJILzdVdWNS?=
 =?utf-8?B?TGtSbUlaY0NFMmFVcFhWSk9nbHJJTmxDa21WRHV6M05KQ2lWUU4xaWpsbmZw?=
 =?utf-8?B?aUtwTTVuK05FaTdVTFlkNXIxSWVPemNsZm1yVlF1SUc2NklyRXVGNi92aHp0?=
 =?utf-8?B?SDVQNGlqUG1JOUFzK3lhT0VoV1VBWDg2SFl1eXFJZjJ5amQ5VHhqUXMzdTVO?=
 =?utf-8?B?ajVCK2YyOFJHUjRhZ3NIUkxubU5Ud2QyL2JheXU0dHh1QlNZOEt0ZHBpSlNL?=
 =?utf-8?B?RGpBUEp0YWZLNDllTWhGK3MvZEwrOWxZc0FqeGlxZW5PbDdvL01EbjE2TkpG?=
 =?utf-8?B?NExTak5BRW5YNzhkbFVaY2tvZTMzSGlqWXYxcFA3d0dLaW1iVFRtSFA4Nm9J?=
 =?utf-8?B?c2s2by9oTTJPNHNuWHFiRHBnNlFGdUk0Sk1oVTVCdEc1Q1NOWGJlVFZEMWJY?=
 =?utf-8?B?YW5XeE1ZNGwrUlN6VnAzbk9TNmdwTjY5Z0dhZHYxZ3E3MXgxREFHTDc1dEg1?=
 =?utf-8?B?eFJnRm43MGY4QWxOTVhvZFFjSFVhRW55ZFVNcVlNSFBLWWF6OGhiZFcxVTJO?=
 =?utf-8?B?KzZTejRmMS8zNkVFN0x4OTRsTERiKy9mdFBpQTRmOFQ5RERvNXhYNHNvbStE?=
 =?utf-8?B?RWF1anp0MzZMVkFBR2lDNmE2ZnhVUEpUSXNCNVlLQWx4QVRjdUk3Yzh2Wm96?=
 =?utf-8?B?YXJCRXgrRlNUaURUS2g2b0xmQkc0TnFJRHg5VDVFdE9HOW5LU2ZFdW5MM1dV?=
 =?utf-8?B?Y0NQOXdLbXRIdmJRVFUzL2d0ZlBybVl6NnBpaFI1QjJlblkvcngrcmt2T24y?=
 =?utf-8?B?OFV0Rk40SVg2Sk9URnUxMS9vSGlXWkNqeXhEVzJCS3BGOGlCdWsxQ3lnMU5h?=
 =?utf-8?B?a3ZJR0pYSEo5SnNEbFo3SWthRCs5allpZHg5NU1iQ1JldHhNaVdGWE5leWtU?=
 =?utf-8?B?R3hJdXA0ckhCOVJ5K0lRVTdMN3l1QXIvc1BNcmpxWTV1RCtXR0FmejRqdzFS?=
 =?utf-8?B?Mnc3MUtLbkJkc1lGSFpmZVBNTkJwNEczTEh0R2FYRDErOWcvN0tSTWRZVmoy?=
 =?utf-8?B?a3JmT1FYb1RBS1VqRUl1VlJDRm15cklsQWZmbWdqRFV6a2dmR0t2Q3NWWjEx?=
 =?utf-8?Q?Ec8yUcHwb/0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWxxMlVFOVVzbVlNcTUwWDIzY0wvQno0TWlUZ0xGUFUvZm9HbVJMb0N5MnVJ?=
 =?utf-8?B?VytrTmJGVWJ6Y21jVWpxb2NORlVwTTJzaDRjUWZ6QUJEaHNHZFdDVnpITm1Q?=
 =?utf-8?B?Q0l1M09qWTI5V0hZalRPWEoxRDZJNXRWM2kxSk1FVGNqK3FZb0gyL20vYWJi?=
 =?utf-8?B?VDNQczh1Ri9VV0M4NFZuaE5OVFpxSGNydEdSWThxU25MYUlYU2h1RndmMFJV?=
 =?utf-8?B?NUFwaEJXcXNEbE45V01Xa3lnU0F4SElGZ1hsV0UrMnAzbXdjOVR6YUpyQmFv?=
 =?utf-8?B?VktyMHRpMVBxME12OXVKMVNrazY4ZDB1NE10blNHYlIwTldSV24yN1duR3dI?=
 =?utf-8?B?ejFwQ1krbXpGSzFJQUFsbytmb21CQ0xsRm1jY1NDVHpIZDgyTVdWTHltZkFP?=
 =?utf-8?B?Q3NRMjdPUDUyQmNDRTdlU3VyVHRZWmdwYUpKZjkzUVU4TkJONU51QkIweEU4?=
 =?utf-8?B?RVRiT3hybHJmWmZvWm1XOUUrRU5VR0JRTDJGUjZYV1hKa2NNL0ZGVERYelFX?=
 =?utf-8?B?Vlo0WGVycHByRTZZdlEzZzd3MTRtUkhrU244RVlnL1ROaGR0RnlpMldxazNG?=
 =?utf-8?B?aGxXOThuZTFBZGNZdTRBM0MxU2lRclE4K2NoSlc0Y2NJdjBKaFE4OHIyWUE4?=
 =?utf-8?B?di92dnRHWE9TaEh4eGNKQWFwcUlJdkNwRDE2ekdyQjNiSUVnNEIzZk9EMDZh?=
 =?utf-8?B?NkgxRkE3ckR2aTJHcDFWcklCVndiR1NRMmdqYXI0cVFCcnNPWG13QTMwZCs4?=
 =?utf-8?B?RUVPeFZlT25VcU5ac3JNSXM0OXFZTkJLOUFGR3NDQmdqNWRob3pNcDJHWVhn?=
 =?utf-8?B?RWJVbFFxZVdlaVJsS0tsVmhFM29iQjNyN2V6TnpzNW1xN29XTHZ3WE9tM29E?=
 =?utf-8?B?ejQvY3BvMXBocngvU0g2WnJlaWRVQXVnZjJTbFowbjRWQ05oRFZON0tpbTk2?=
 =?utf-8?B?MmRLNklSdFh3TWN2YTYvZmh2cGdJRVQ0ZjBSQUtGZ0xBV3ZPdTgrQm5Rcy84?=
 =?utf-8?B?M3IvUzROVFJGOHN4SG44aEdUUnViZjdndmJvaEZENFdXRURjcHN2aThXOCtl?=
 =?utf-8?B?Umk1bEk0cWVhSGZxb20xbXg2MW04cEI1c0l2YVdSeEk0V1dxYkRKd094bHZy?=
 =?utf-8?B?ZEV1NitweEZvdHFIcWhCcU9KNUphbjg0Z2xVbWZ6YkVjbmNxM3NOQ25vSFR2?=
 =?utf-8?B?RHVJYjRlNHgxQnJEUWVUOFllZ3ZaQkNLNm9Yd2NSOFg5alJEV0YwbTByL0Fi?=
 =?utf-8?B?TXJlRkhPaWxTRjQ4ZDVHV25qM3E1SEVJbWRlMTNYQzRwNXBUcTFyZ0M0eG9h?=
 =?utf-8?B?K0dBMUdWSDVVMFJGTWJoMmtGSU5rMm5naDhmSkxnTForVWxvMFdMVE9PZnJt?=
 =?utf-8?B?SzdSR2Y2K2hmaTZUK1JKQi9KQ3JGT1U3b0orUnB1dmcyZTBkQyttUGRlb0lD?=
 =?utf-8?B?ckNkZ2xqajZjczE2dGNDWnhGajl0U3BIN3BnUGVreGllMGdqVUg4bXNvTVdB?=
 =?utf-8?B?RTBFcGw2NmQ2VWU2ZUJRN1M2OUZ3Y09nNXdRQXJ6aERpWUI4OEE1T2lLMEJ6?=
 =?utf-8?B?bXJMWElaUVVNTkwrS2RSNmhZQklYRURDMEN3ZHk5MDU3ZXlYUTJ3WjdPUllH?=
 =?utf-8?B?RGJkTm94UTEwYUs3MXowZ2dodVRtWlVQclQ2UW1IYVgrNFcrL3JzbW9lNXVF?=
 =?utf-8?B?QnQ1L1ZTczAyUEwyOW15SW8wQVdNTU51VDlBUFd3a3Y3WEJHT1BxaHpBei9N?=
 =?utf-8?B?RmJhcHgvVkIyM242TGpsZ1ZHcG5sOG1jbGo0RjYvekYyYkI4aThoVkx5b1Jk?=
 =?utf-8?B?UG5OUXFTTUZwVk9VQi8vZzNLZ20wNUJKN3orTW1MWi9ZVkVCZkpzSWFTbXhN?=
 =?utf-8?B?TmhXMmN5MGFIdXh1S013dXR0NEtkbFNCWXMyckNHbEdncW8vbmJGa2I2dG5m?=
 =?utf-8?B?YWozbEtZeXQ5RkdJbXpHOUlCZmZVWHE5TDg0WUFHNnpLRitNUFBVOFRDanZa?=
 =?utf-8?B?RmtpOHM4cmxWU2NDQ2RPN1Z5TFBRc25kNzRiaEtlUVdaa0lnNy9oWmM2VUxp?=
 =?utf-8?B?RUtUck1pT09qc0w1SUM3eTVQKzk1QlBFNUNvT1pmZnRRV1R1OGNwdlVwVC9z?=
 =?utf-8?B?emNSR0JjbXIxKytXY3pYcmNIWmFzL0xQeXVmdk95SWx0WFZ3dUZld2N1Wk93?=
 =?utf-8?Q?z8IAp2slXt/Kdx7pddgmLXAc89uvM6eip7szMxtpUlFM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h/S4iFcX99izXruOdXj/e1RLHSDXhI/ovaqco7LoRCjHje0fRFcPRdgpgzNMUdiR0hdsC14huIvmICI9se7gLQufuN7N9JEM1Yp6o/pbEBKs35eGrcgk3K3e2hGErFpckitD+RzpOZiGCnYYaPw1ubB8cN8znHDTbtxSNTr4iCkf9Pb3hMNKaSLc/YqySvdyaqVIBKAYtoVgSPIwMk2HkzVWjTsu/EQFKKWU91RILLxLjmqmipyy2GkgGGmTLZrcMcNy7Nvq8ewY17poPfgeeQjjhGvs25lD4ywKGeDkr8Myvz+RWp2CEHDMBvFUx7iBfmW3dcbJY6t1yFVKy3p2a1YF7NQv/pHVIZ8NXargiymEsrBEizvPZIKcy3iSHleetvg/lyUma+hON8xlGo/AhO6n206pr1t101UPgsdOzvL3thwy0coHrPPAq1DoyvGC68O5abxWHnt9gjCbC/QWtPt0QJ7Fji6O46XUrh3terN31JfC2qPinZTusPQpa8n24ylo4JmnQN19XNJ2BjqHfck+dgwx9B4sDqlJOz/qg9/gfwoUoW0ZRLpmrV4tB1loF051c5syCtU3C+RkTk8JsOiLLv78BnsVDv5PWonRDh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c3e40a-cb6a-45c8-8e55-08dd840d2b2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:23:45.3710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnxd8dCjq7ifSY+ZtZKxgrsslXVMgs7Ns690MpqO/ja/lu9kvV3L4o/2B5IZCy2a9zJIhL8FpdubvpwvRf3VBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250109
X-Proofpoint-GUID: ftDQjyvvsN6A8qz5n5-EyVBoBNpPyMTe
X-Proofpoint-ORIG-GUID: ftDQjyvvsN6A8qz5n5-EyVBoBNpPyMTe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwOSBTYWx0ZWRfXwo6WQPe7p1zO IGC+5xJcKdgUJcpmVZsxjz02ggH4KxSWfVIfzJ3gIA96j4KgtszwBlMRrSOeotg31CYsR3qoFjB LaDty/5HowJ3EWrObRnrwup26NjSlcpzIm/C2ROK9YQ/cv2CIXSQhuEXiEq7DY55vM1MdI04ZXM
 o9PLz6F/7N77tChnDuwKhCKoQLUqWTMvlDffRKf9AxUgGdF9Gmi3/eOEijOdYcxkBmiIvpVVg/t D805lj+iIFFI6z1Q2WzqvOMuqbzkbUEfTqMPbgKV6uzuQRm8e2vF83TExI+8HRmBqTi+Ku5ZvAt YpWTi3y4lYutWpZlxIT6t5vXlyhRku0fRB8u9yhbpIYl1poGfS9l6NKFCvvExuDn3EEVq89Ygtq fT7s5v5V

On 23/4/25 19:59, Zorro Lang wrote:
> On Thu, Apr 17, 2025 at 08:27:22PM +0800, Anand Jain wrote:
>> Just adding a _ prefix to the two temp fsid helper functions and
>> a rename in common/btrfs to keep the coding style consistent.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
> 
> Looks good to me, I'm just wondering if the _mkfs_clone should be
> _btrfs_mkfs_clone, due to it looks like a btrfs specific helpers
> and this kind of helpers nearly all have a "_btrfs" prefix.

Yeah, it should have been prefixed with "btrfs". Fixed locally; v2 sent.

Thanks, Anand


> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
>>   common/btrfs    | 6 +++---
>>   tests/btrfs/311 | 4 ++--
>>   tests/btrfs/313 | 6 +++---
>>   tests/btrfs/314 | 2 +-
>>   tests/btrfs/315 | 4 ++--
>>   5 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index 3725632cc420..44c9d6a6777d 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -942,7 +942,7 @@ _has_btrfs_sysfs_feature_attr()
>>   # Print the fsid and metadata uuid replaced with constant strings FSID and
>>   # METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
>>   # it matches to or TEMP_FSID. This helps in comparing with the golden output.
>> -check_fsid()
>> +_check_temp_fsid()
>>   {
>>   	local dev1=$1
>>   	local fsid
>> @@ -979,7 +979,7 @@ check_fsid()
>>   	cat /sys/fs/btrfs/$tempfsid/temp_fsid
>>   }
>>   
>> -mkfs_clone()
>> +_mkfs_clone()
>>   {
>>   	local fsid
>>   	local uuid
>> @@ -990,7 +990,7 @@ mkfs_clone()
>>   	_require_btrfs_mkfs_uuid_option
>>   
>>   	[[ -z $dev1 || -z $dev2 ]] && \
>> -		_fail "mkfs_clone requires two devices as arguments"
>> +		_fail "_mkfs_clone requires two devices as arguments"
>>   
>>   	_mkfs_dev -fq $dev1
>>   
>> diff --git a/tests/btrfs/311 b/tests/btrfs/311
>> index 51147c59f49b..9ac997dbba61 100755
>> --- a/tests/btrfs/311
>> +++ b/tests/btrfs/311
>> @@ -47,7 +47,7 @@ same_dev_mount()
>>   	md5sum $SCRATCH_MNT/foo | _filter_scratch
>>   	md5sum $mnt1/bar | _filter_test_dir
>>   
>> -	check_fsid $SCRATCH_DEV
>> +	_check_temp_fsid $SCRATCH_DEV
>>   }
>>   
>>   same_dev_subvol_mount()
>> @@ -69,7 +69,7 @@ same_dev_subvol_mount()
>>   	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
>>   	md5sum $mnt1/bar | _filter_test_dir
>>   
>> -	check_fsid $SCRATCH_DEV
>> +	_check_temp_fsid $SCRATCH_DEV
>>   }
>>   
>>   same_dev_mount
>> diff --git a/tests/btrfs/313 b/tests/btrfs/313
>> index 5a9e98dea1bb..d55667f733ee 100755
>> --- a/tests/btrfs/313
>> +++ b/tests/btrfs/313
>> @@ -30,15 +30,15 @@ mnt1=$TEST_DIR/$seq/mnt1
>>   mkdir -p $mnt1
>>   
>>   echo ---- clone_uuids_verify_tempfsid ----
>> -mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>> +_mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
>>   
>>   echo Mounting original device
>>   _mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
>> -check_fsid ${SCRATCH_DEV_NAME[0]}
>> +_check_temp_fsid ${SCRATCH_DEV_NAME[0]}
>>   
>>   echo Mounting cloned device
>>   _mount ${SCRATCH_DEV_NAME[1]} $mnt1
>> -check_fsid ${SCRATCH_DEV_NAME[1]}
>> +_check_temp_fsid ${SCRATCH_DEV_NAME[1]}
>>   
>>   $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
>>   echo cp reflink must fail
>> diff --git a/tests/btrfs/314 b/tests/btrfs/314
>> index d931da8f0293..659a85d39886 100755
>> --- a/tests/btrfs/314
>> +++ b/tests/btrfs/314
>> @@ -36,7 +36,7 @@ send_receive_tempfsid()
>>   	local dst=$2
>>   
>>   	# Use first 2 devices from the SCRATCH_DEV_POOL
>> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>   	_scratch_mount
>>   	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>>   
>> diff --git a/tests/btrfs/315 b/tests/btrfs/315
>> index e6589abec08c..90f77413bedb 100755
>> --- a/tests/btrfs/315
>> +++ b/tests/btrfs/315
>> @@ -51,7 +51,7 @@ seed_device_must_fail()
>>   {
>>   	echo ---- $FUNCNAME ----
>>   
>> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>   
>>   	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
>>   	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>> @@ -64,7 +64,7 @@ device_add_must_fail()
>>   {
>>   	echo ---- $FUNCNAME ----
>>   
>> -	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>> +	_mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>>   	_scratch_mount
>>   	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>>   
>> -- 
>> 2.47.0
>>
> 


