Return-Path: <linux-btrfs+bounces-2974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C186E68F
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7BDB24EA0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719FF2568;
	Fri,  1 Mar 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfvXBaCi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="shDo9I8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A874417
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Mar 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312401; cv=fail; b=F7KIUgWl2Kdj30pT6VEdd0M5jI+SYpSSPhIimmG7hGMUWBNVT3b2UCipwRNMb7Px9wJ3H+YxNIrkHXQluyK3uJV3PnN+L7aV07BMo5PtrRyHdP7WE67MY7Izbv7Ss5KnBHfseRLEMXHi9AobVnpcdC2lzBdRgZAONbyn1LY8uHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312401; c=relaxed/simple;
	bh=AMU6KDAhGq/nXhwQsxkif3zpQouiuqW7EEwoQXtEdiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KKICHocG14UT2v7bpOuKQlsBS6reyON+cay3Fyee+G+5t8NX01pux8KpdLNOIfr9rebjcA/PsAmf3DbSduRBYoaLwsdjM6QHYsfLHb9TH2s+vvTDas2C7fzN3HTbl30MH+8CIvEN8adXPcFZNy278ybyYRQshkjijdVBtzJkVjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfvXBaCi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=shDo9I8t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 421GBWGo026129;
	Fri, 1 Mar 2024 16:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hXgkTmWSRF2fDFUrkrwmKWjwQodYMU+6sJNsSob0Yew=;
 b=bfvXBaCi2WSF49HSXQJLmFPzQVkwVMt8WZfbc05hDtLJJCz7R8aWy0vi0nUSOX2zx7mv
 aewyrEyDrYVTkAGgQc41ZF4WYWpn1q/MWI7VEPdUMbjtnwLIeDrrwZGyok816k4fHOYS
 mZ+weIfmVKtM+iDmq6ertuaEj0/DAiIzrfSp1cDTtg3FEL4dAv6KehRPop7f171EOfkC
 8C+apOqz1RnLntbTf/k9F/Xpq0BgzBlEEWeSdtiQ+lhPeTPj2GuKYVoqbSoWj2z6NdRs
 5wsuBo2Q1GwG0C1hYFpIdxhrCb7hllcqnMnzzf6bejjBLpLzhGJAqFUVw3UgqCZWgpng lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vhdb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 16:59:54 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 421GhpDu015485;
	Fri, 1 Mar 2024 16:59:53 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wckgkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Mar 2024 16:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHUJYB6a5wvI9Kf8RkBaG8PDLSPdI/c9dW5aTKtA/qG9lhOGrTXg9WbIiEYwxV0kJ5Kj2gsAik39ynniqx7HoR99jVaCa0eliBnJmDvXt1D3tyzd4uBFBnehjUZar5Drqbr+uZfzlJ5qpzSDOOamzWN2+eMUg8L1vt4fmULsnhILQm6oV6JQs8iwfD061nRWlxmsGErn+/TgPQxXVzCrxqMuiNhwQ1B8mrEij5TNBvHhbixF1QC7XXo4/HqUmfYoT1r5f7p5mc0ZCO3KP0rdLIICo+5sV6wR320nMLgfUI0CNHytAZRNCcFb9jFaMusB0OqkggHiWO/WNUJI9ocOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXgkTmWSRF2fDFUrkrwmKWjwQodYMU+6sJNsSob0Yew=;
 b=JNm31ebtb5dAHjvc9ACgkbyBXUmPNdOBCPZFdLY/B8FjxfaiGqH1ln/iAPnIKZmUO/pDwBp/pdGIMIvsn57o9jjzADcXkDh/jyUG2NBv5Efuv/zBaKLkMhwH5KRefSQW/8aNRGSlIa50Ur8eaEi6rk1Qsh1EQ55pqEXS9h2rqZ6/Hw6mbSIDgw/FiX9mvXcI1teXdbmN6hc4BAUHKFS56XNcGuoVm7kSZLRGf7QATb5GBCQ5kb4VNCKhqP3UnmLzBIcah/UdbFwS6mMZWeHD8sDSoU/UkIQmjHvfGm+eOWuhuEMcLktePfJbLo8cY/klf9HwlvLtxWyr33B6kMCV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXgkTmWSRF2fDFUrkrwmKWjwQodYMU+6sJNsSob0Yew=;
 b=shDo9I8txYa0rA/tSsddaApifYrswuY5rryiB00bJCc8fcgTNWV2GwNtvIWYmzm/AQr+q3ri3aEqcWSPk5bizTvnAnz86wpg5EG7m22SWbKL9V1lpQ3oKQQ4MSxeYh+y01GPGiCxfmktPD/jI1/V3IG6oOt4VyZ+8cb/1pJirLs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:59:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Fri, 1 Mar 2024
 16:59:51 +0000
Message-ID: <4f6ea05f-81ca-4ec9-a585-7118a7395434@oracle.com>
Date: Fri, 1 Mar 2024 22:29:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate device maj:min during open
Content-Language: en-US
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <752b8526be21d984e0ee58c7f66d312664ff5ac5.1709256891.git.anand.jain@oracle.com>
 <20240301153440.GA1832434@zen.localdomain>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240301153440.GA1832434@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a6c417-15b8-4f6e-7157-08dc3a110285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2AHcsadGrF9JELU1pbH7TQhd3uF9Yl+FokaBiIbSGtROjHQ9C9fFWTEAfYZks37RqiJ63TXBSS5JUof5BZP6od+iuTm936oNEPeGt0P+5Do892eg0TgssjlSde6JRCvc5Z9cCg/zwTwy6Ocms9ZvZpZhFvV49JhyH5u1Qpy47s0f9uqs+erpDrT5vcbZFFsnJlazcizFVPsKQ7sHLHuysV0TtasiNYy4mby0y6yytWRPZYAgJhkQD+FZsUMjSZzGu6Cl9+VB07XiCDSrSaVCA5aYeTePLmt8vfUYDFNe+MZXZ7x1L/G17bs6+izm/OYsohvIj/g/mf7mYy/NdAfqKNUSFC9VGMbnLIU/pRctzZFOTnA7kKKtJdNb7Owu/Ar0QhE/4fEiBmXBsIH/zwqvSPG2OJtg/KIfbBZrxPtsXqx9mjdTfXkFybyr1feVRm08KfUJbELO47vqz3wtTwTgS+wBecSEe97hYc2vmTJEV/XXWm2X8nT+eG0U1pRMCN+JU2wT97xk+k2mMwdNO4H5RBZfGzH361MPR2eAXfTNOTlbdmqQHU3Hcb26Xdn7pQJRierRvQoUM5vuHb986B/b5VCXK6gNQeNeZAWNAxZR4TpnP+fgwrqHhEf5MlCC/oOEd0CWbCPfAHw3FRHvlbGpEw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlJkdHFsWlpoN3EzU2ZHZ3FQNjZXQlBWREkwRU13WjJLQ1kyVTFFNEdDYWph?=
 =?utf-8?B?MEN0dVUyZlpXc0hlSUhaSENUNHh2czBUM0lxWXVxNkhiY3dYT2poVTZNK2ds?=
 =?utf-8?B?T3hpZU4wOHd5L2ZaU2l6cXNibnJyMlZUeXR6NndrVDlvMTI1MXUzS3o0bkdo?=
 =?utf-8?B?TXRtLy82YzBiTzh6c0RUd3oveFByMFhlZEVFcnJTd1J6RXVXMGF4QmZXRjB3?=
 =?utf-8?B?TExpVHpBZmxuaWJQckdsbVViT0pMSmdkS3R6dXJzV3krUm1XM1RoR1kvdCt0?=
 =?utf-8?B?N0laUURFRXF5K1N1Rk5lTEU4R3RqMlZCRitJczhRdmxYWTZVeDVGdzdlSXZX?=
 =?utf-8?B?b2Q0NFdvR2hHVklBb2xJWEIvNkovMWNGR25NOHgycU5YNUVJVTFqc2V6K2Nx?=
 =?utf-8?B?amlFcnVIZFBrbUI4OURSS0dTek4wV0J4UHhHV3VZaEg0UHQwRjBBbDZuakFV?=
 =?utf-8?B?L2dLek5FTUpCSGFZY2REVUZUR1BhUGVFZmVoZitUUmdRS1Nxd05OZTJSVHlJ?=
 =?utf-8?B?b3Q2YVBDNWltTU9wK3VnVllNQ1UxVDA0M2ZZUnZTbVhJeGZTZFh2ZXh6Qi9t?=
 =?utf-8?B?dzl5eGJXRm1tTEMzZ3dicVhjYmtaZ09WSFVlVmhLZVpxNnNuWjlOWHovc09u?=
 =?utf-8?B?N0paNGNVdXhqMm9lcy8vWkhGb1MxNERwT1M4UjhLM0oxeXQwcFNLdFBQVi9S?=
 =?utf-8?B?NFFPaWRSNHdic3BDSmIvaEE0ZlhDVUlXbDR5NEwvUlc0emlYQWlPdytnVUZ3?=
 =?utf-8?B?TndjRXQvRW91eEQySXIxWWcrSUIrMW1HVWNZVWsvVjZWU3FsU3ZUSU42Ly9y?=
 =?utf-8?B?SmxNZ0hyWTcrY2JoM0dqcTg1UUx1OWxYSUpGemlHMGt5M2xMblAveS9jcmxy?=
 =?utf-8?B?NzFzSGcvOXE1Zllrb2Fnb3VNdWdJMkV4cm95RE54MzB0ZGNyMmtSQWw0ZUpP?=
 =?utf-8?B?Qjczd0FNSHpuOHNIRFBvSnFVUG1QQ0dkbFJHUFlsZzhjYmwyazRzbWxuQ05G?=
 =?utf-8?B?NC9GTm1KN281Ukc5eThxTnoyRlZiQVpjalpWdjl2RGltR2dDcWJMcnltSzc1?=
 =?utf-8?B?SGoxbmk4NG5CNnkyWFFWRk5YM3BEakgwTENYY05XeldLbFI0L203K0hUNlYx?=
 =?utf-8?B?TkNvR3hLV2J4U2NFOGtjWDFwNVRuUGdWb2pzTlZoNnkzTGpGazR5ZkM1azNS?=
 =?utf-8?B?NWhseHM3V2E0RUtsWXRnQ3ArSDVDNFhhOExGeFkvODBBZmloZHpNSFMvdm5L?=
 =?utf-8?B?VFo1eTYvSFFCUEdDQVRGZ1ZNVWJnTVpocGlQQXhpZExPTTBoZ0NKZjl3QU5w?=
 =?utf-8?B?NkM5eXd0cG9LZ21HRitQWUorLzhTckVKTG5XTFpjMjNra1A3Qk8xVk5RcHlF?=
 =?utf-8?B?VmhudXVnT0VMemJ4VTRTUC9nUC9udXB1RzUrREhOTkI1VjIvTFBLSjArVDBq?=
 =?utf-8?B?SEFMemg2VFJMTnc2ZTBtN1JPVnpWNDZ5aWJwaDA0OWZKWjBwWmpGaXZRUnVu?=
 =?utf-8?B?VE9yMFJEZlduQlluclVGZTZZYk5vWU11MFJxemdoMXltM3I4bzlnbitCK1RO?=
 =?utf-8?B?UW1BR0dRSVVwb2piOEVSTFRvcWUxaWczQnNRbWhBUUMwSzkxU04vRDl6bVQz?=
 =?utf-8?B?S2lnb3VkYkp2azZ6clZWSU5SZDRITHVnN3lLZDJjUHNGbkpnUG5PMEd5Ymgr?=
 =?utf-8?B?c0ZCcEl1a1VEVlpERkEyQU9sYUNiUGtCMkxEdXRodEgyUDF3NlJzSVJKUkZr?=
 =?utf-8?B?VWFrZForYmNzNkUwWjJzSy9yczN2NFRSc0RZUG5TWURmaHdtdVVKdHlxSWhj?=
 =?utf-8?B?Q0ZNTWcxYmc5b0JzbjE3UGVxOXBGQjVWQWs2TVBoVzdUTWdFeCtuY1dvOTA5?=
 =?utf-8?B?emxHSEMvS3RudUZTMlBjTDVPVU9UTG1YYk4zMWttdUlXTzVFRmpTc1d0Q25z?=
 =?utf-8?B?NWlDcG9ZMmVEVGlKbEozWkU1aEsxTUZlTUtLay95M2V4TTJwK1NsdkltQ09y?=
 =?utf-8?B?c3JZQWJTQVFzbkRGYS9QWlBzWUw5ckZsbnRoWkkxUkpTSnhjMWVMK0ZITkow?=
 =?utf-8?B?VFFvVkxaWDNmMHJkcmg3RXBxQVI5WVE1VHA4RDhTeE9HbHB0VlZ3Zmlpbnlo?=
 =?utf-8?B?c0orbzNVc0pYOGs1OWo1NmRpYWJoOGpZNklFZVkvQTJEUGxINkF6clF6TUUx?=
 =?utf-8?Q?2mLLZ2QbHQVysiKq8hxL3EDxHX00dqBriECxQSMlsBpx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/7fsXUk+lm94qqJMTwTYvD8AVR69a0CO5W7jej+0v4ch0FuBDkcswbZxD9VN/XpzanOK3izX9GWnS6GB3+AbeQX87vvaHg6QX3SyZ0yWq2qfj4wSjBsqVU2xdfuDtar3IBnoj+wCY2cDwXjmjUtpJ7seQEjrQECgHfQqJKwU0hqDQOA7DQMty2z7tGDySSUvoYmgz7Ecv2rMcPG/LOx89Eu5+LaiJ8/Jmxfi5QQLseE1pgYDCgKSh7Ca0k9gU36t8KS35TIPNyhOFS8o0QzEbhliUOhtPSP39yxzHIO/LHz5fFGOqly8/Or1w+0T76nPG/2p50kQv+8Q9qGI3F+4BfUyB/sPCNyLdYXPXFO6sFomL2uP4G8cOfkFV5Pam9eLUR1JJunk/BEe2XRbZHLOFuu3A/RMZODwc8BruG+1G7MVPo2UBnyKpUKLT803vYvQ9ZrrTH5MKx+j0dQTgnV8xma0TAGLcXN/BbrNZVq5i/vhWcDt4Q6uiL2uw+eMNw7NcMj82tQkd+n7PNAcstcoYRM2QvH2VMsjwbpErjK2w2c4AthLUQ9O3QM4LjF7NmMejTlWygLp/NsEAcXZvbcuj3X7YPGR+tC1SdYErJwrlgs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a6c417-15b8-4f6e-7157-08dc3a110285
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:59:51.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRDKReJeBKtyvfNHav5t82E2l9vM1vvExtkimXm6zY7O3ZDmmhjSaQlSkbkygsn+Z+l6rDx5LmkDejrUGkgRoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_19,2024-03-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403010141
X-Proofpoint-GUID: vza4JIKQLjEorg2E5VWaTsN6qrpqdkYh
X-Proofpoint-ORIG-GUID: vza4JIKQLjEorg2E5VWaTsN6qrpqdkYh


I missed a comment.

>> @@ -692,6 +693,24 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>>   	device->bdev = bdev_handle->bdev;
>>   	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>>   
>> +	ret = lookup_bdev(device->name->str, &devt);
> 
> It should be fine to just use the dev_t in bdev_handle->bdev->bd_dev.

  Oh. That's much improved. I'll fix.

Thanks,
-Anand


