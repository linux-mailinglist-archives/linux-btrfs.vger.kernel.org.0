Return-Path: <linux-btrfs+bounces-13923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF7EAB42AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01D41B61D4A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5882989B1;
	Mon, 12 May 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CCTCNdAU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e53ciu+O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA4298999
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073282; cv=fail; b=m5cIQ5FgadFQT/RGdIQ+akgjXsO5HgXnwKvH1KGrI5PmBRXF+QZwrq3TT6Y/q+P6IHpsjq/dnUiTafPbZkkLphcImrJcyBTChdqB/ju2421bnTqIL9nqVr2HxxN4+xnnmYFfPpTbJTosK9wJ0iUaDCSbu0hvBWV15trL2f99sLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073282; c=relaxed/simple;
	bh=Fqf6S9Osu4VOgmgoxe8ak3MsohlFs4XSS8X8RKt7iME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILc65jUEvbn23m2KAugUhKwtbIM3S1caC1LUOGGUrEjXqH/nLYmIV2vk5/ffYPVfHUH+sl2VyByUms5g0V61/DHhpigZYbBIA09RqxUHL398wGB74Nc5TUj+xxtpsOZxtDKskmaEQFymBuIKXcFF+SYPT/VmN5ugbXfQq0RRl9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CCTCNdAU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e53ciu+O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0unE007074
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tFZp/+flB53hWH7dlIm0Lp0r5kSkJ+zCHRqnTZD8Uhw=; b=
	CCTCNdAUELUFIN+ZtGZASBHcOIXCIdEW1WIySBo8omMm2OCjCCAL7L0XRIafR2qW
	qn88i2hCb9U1eDAwlRedY8CZKg3b8YPzX7kJyksPlXUcVLXomRk1CjnP/AsusIKF
	kxr4IkrGklUO9k6rEB50ncMxDx8E/wrNM9sI5rhPbjBAWWlVo0dvVy11nf9Rhl0B
	V+RqQ1noppLv7vuia496WIkUr8USk+1YbZI9G30neZDzxPHuC9jAPkl6nGbFZMfo
	7R0rNFI+OHFHWBNWph03htmYoQlPTk9tvmkedTzElpIdU6fKOBa6wPhqUZMXadTc
	bubRpJPBCDT4zvo9MfbreQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c33hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CGx9Bw015449
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:58 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87pynu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqFDKZrBy3ZDJ6ZewaQVdg5tjXlXiXGr8XY4GhDKQuvjpNBzOXOaxOlCunOjUw+mm79Dpepjc5jGlDO9J6WnkI1MSKRmEox4s3+1JHymEDCM8Iguuz7FEdq+cKQlyhH1Y1syhHXUxkTR6T5LDIxXHrtE9WDYkY9AIlTlU5YOA0IfU1rFmQ8N/YmxSBgwDGbyK/RRc4Ynjla2OltNSaYopuPlsuVuj6uCPNfZohcp4TLSBdBFQz3ZjoDbAOsTSKA76paw+gtnCwHYnf+UTAY7w7FDSFIulpJ88IWcppkCiPdyorEEeOnYSU1YJHxqZrwnB/aNTpmAXGHxwyatOBJMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFZp/+flB53hWH7dlIm0Lp0r5kSkJ+zCHRqnTZD8Uhw=;
 b=CU9K+p2WTFYEM6JCYlNPB0ZTtf1kmED5Q87EGhMPrcCSguCNG5BjFti+D9KGyjBWGdI4jvn/GZn/7nnLtfKcUAV5AmuophhsH1O6Ihp6xUtomENqSOvmJFB31z5DIHauL9v63G8dLDuEZWBwFQJLCCGE5sY+jcfRlSSbAJC4zZwnq5AtJ/go61FmcvkX9/UcOHsUwgEKXV24h91Ihy80XQGPWCZoj/SY5WulQKZyiFk+1AsZaWryPcwAU3O4ObwrSz/MM3zrOyXAPOci+XiLevEQWmswaEsEYpl8aNI3ScCvQTosT1aoHyuTyJEKG9ig23SBBS/uzfawsG3BWKNMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFZp/+flB53hWH7dlIm0Lp0r5kSkJ+zCHRqnTZD8Uhw=;
 b=e53ciu+OgsawhZVs0mb3X2T7k7PoE6djZ5IYahFck8c0SHq4CnrREVpWwINQ37GTTZaVrypo0vU3mXp62xWOEziQR1iUMpodI9dmhZW6Ag4UweZltWRP6EJGF+B/3Js8mNMUx1m7RacN694V/WXLqebiHVY9LFbg11dlVSm+Rk4=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:07:56 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:56 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/10] btrfs: skip device sorting when only one device is present
Date: Tue, 13 May 2025 02:07:12 +0800
Message-ID: <40643b80906c686f31202a41b785bc8586adf3a5.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: c933cd32-9f19-49d0-11f7-08dd917fec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23tXg2tWNG05+C40mGoYxwrZeXB40Md4Rir31gMOJysgjzyIES5D4gsS4Efb?=
 =?us-ascii?Q?h8OXTj57/INe1Ni+UQdML27eHfJIqOlP8c3VTlp5p74pcrirZtG+0NzKnIh9?=
 =?us-ascii?Q?Z5D3vXFjO8AC5KlIesTWM+Qm9097L1dVaBeFUxIKUTf07GaqDS1jHMJVgN2P?=
 =?us-ascii?Q?kBqsVlxw+MKpU8SLbL0BXY1kAgpCxOUWyvVtX8CaBeo1fk1hZ3XlxpWKNyWD?=
 =?us-ascii?Q?zLTeHFSa/0feowM7lz5DyrO7VrBO293m2O6kE6CF5YuwzuXTrbUKgXftX12s?=
 =?us-ascii?Q?SGYjYq/GI8wxbDeLj0YQD4Bryxjx4NDClJwi2JwIaT45C+UdRdoG50yMtWU+?=
 =?us-ascii?Q?GGpf2u0jc1St9CDJ2zNWjlnmPQ15sruK0onCTuBrXfxC5Q39gEftWmVfth89?=
 =?us-ascii?Q?zDSXnuMVs6RnVuGCVKjgdj7egHTBOrux/g9K7lEorfeJqbsYUalspT7UMNfs?=
 =?us-ascii?Q?ewsUIc1W5TB1x9OMoR0hHIgt8lHLOi/aR86PPqwpg9KsDHMeQO0h55ML4bRb?=
 =?us-ascii?Q?/87Z04RqdCRyBrBrnH6U1FrmgY/+bXonksc5tDFe5wNlxTrjKQGoYGi+aytf?=
 =?us-ascii?Q?irxi/f8AGBT0xjP2J1/NCW/E4E1RG+OoB9bzTiQcFzRtZp14KQm9HkD4Jzql?=
 =?us-ascii?Q?A3o9ECUN7OXVBzYwsMG706HHrimKzsmcNJthCf1FG6bmd/pqAbL5TOt3589h?=
 =?us-ascii?Q?QfDRxpBswJavag4BAqeA3nl7t8aeViYgXE2Mijeg54NhIkvy1zGch9zfzlTt?=
 =?us-ascii?Q?E/qawIUKtNGHmPTnal8dv7GQboLQN/yeGuKEkAl/Gh/h8bmOPkiGXpnflexz?=
 =?us-ascii?Q?6n6Zg6qor4Rw+udHye5FO0CYw5XBBR7QlWZGWVbUBDkBL44+7ozzUGePh9Hd?=
 =?us-ascii?Q?wMF03tN57o9NmfjXJbCWgr38ODlO29oJlRv1Bk6JAo6fBblTbZ8oAplQfc8u?=
 =?us-ascii?Q?c4KmJmKMd+FDiJJwX9JtZBvpeMXvN5QqTTnapHwmGtoe6So4Aj0KwkK+fQ/P?=
 =?us-ascii?Q?BDvX2CIwYWMqrwvvsLZ8c9YeEBkIMvh8+7hCZ028vSXkRLU58UKWtQHwoIjR?=
 =?us-ascii?Q?DLheP+EWQdjWxQP+GeCYDOi8kPOEh5q56r6eA4q6xE3iAAryFyx4EqxsuzWF?=
 =?us-ascii?Q?wyeA/WCLUf3rGJk0sM7J5JaXQ3ni8cegCVpKmJnpYBpvYdI3k7ZRHGAXp/l6?=
 =?us-ascii?Q?AU4sg5k0/WoM9eSRj4IFsR7xEHlAdZi61iOAYogDjPYg7B233D2hnJX1skXW?=
 =?us-ascii?Q?FGICs/mphSYujjNXkuhT+yV/8YOMDlSRyyFKv/5n78CBqlI13TeMfqojKLIg?=
 =?us-ascii?Q?I2lQ7tP9Zqykxmq42+jPFqCAkblC3j9Z2/SMSggiyh0zOJ09RriwXiNTySGq?=
 =?us-ascii?Q?x3KW0MmXc6DGdF9TgVtP5Mh9YFJRIFmtwsax6TrqkEla3MohhnsJ+0LwZ8aX?=
 =?us-ascii?Q?V3Oi8Hy4wBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lK8C+Ydp0wwFiKYc6pXkLIpQx56ppSiACVSCuZ1tmcPPEzU8a+4BCaB7M5LH?=
 =?us-ascii?Q?/5lHKfwTG3arAdkprN5Axuu01RxK3IrHKgNJwwVnich+ztiW42Lzw/y6mQg8?=
 =?us-ascii?Q?a1tGDhN5kZrQF0k7alrfG9fuB9g3I/yGQ5zWJcH0aYLLeyoT9l5FB+sIyg7A?=
 =?us-ascii?Q?hX5H8SPeO5IwrXUFqRmh1CZ/jpqRkjA22s2UzLnG+PAYdjHxpYjRVz7mIPeF?=
 =?us-ascii?Q?Jnze3NTBgaBo+W62AJkwQgLM0Gb6L2gCGJ4RAO9nKKt8lcylX0w9SmGha6Ua?=
 =?us-ascii?Q?XVbq6A8DfTnkfLLfauTaQ5ki8PC2SaJiTFrwFHLBNm9+kiJ5++qdBnLrTXbe?=
 =?us-ascii?Q?GOwsu8a1vHo2y8TNNQjqyyFRl2YAgza0U2f1CWfMnMCP+TKIq96ZJIfdO7pj?=
 =?us-ascii?Q?wu+qYV9PNamjKLNJOC8Jsa2KtLlfeBftiSR8R1h51keEIThA+ZhiijE5cYZJ?=
 =?us-ascii?Q?dKkuX3NMZhX5gJNiRJZKn5S+gtmhbH4ZDm8lbHJ+sU4yu4DMhZmJ1gq3u5oZ?=
 =?us-ascii?Q?q/BAwxBK99cra82PhjGXYUFYt/D3BYhV18KwVMWuKcqzqy/QyMon1ZAl9GO0?=
 =?us-ascii?Q?qUrjrFHkxiquyhU3h1T1xW0kpiOmFL7ULPyDG2j4WmG6rttkqvrgdibK1Gpa?=
 =?us-ascii?Q?UMl3g4n7988LQAEgkKs1WjOjQ6Z/bfeMQi9J3sWtqwOYa7N8ZpLqeSJaokwv?=
 =?us-ascii?Q?4AdJm+8TefPfneVy9dFw/Q0XCQV1ATn8p7H/0lLgZDcHF04kbeEvD3jTe8LX?=
 =?us-ascii?Q?aGEjXQ1O05WWPELB07atb3s/DR5vCrXtGvIP3TnbJKddPLbZn29VPisd9WZ6?=
 =?us-ascii?Q?OTKrOVuD1WSpHHshGnKXQjTsmpm55CYEAYFNt3Zkkg4EnLQ1FdRFzvjfz/jb?=
 =?us-ascii?Q?M9mG4gM0/F2vqKL0wrIwIzN2hCsF1b8svz8OsjXOyNnVP0NH5tnieaNaYVmJ?=
 =?us-ascii?Q?wIYdFEYGVspr6RzcdFG9rH2FZwv8uevuZGJZOUWP58WsUYSGUO5oc46VBZ6a?=
 =?us-ascii?Q?+gfYngoIDjtV2dv/g39St45kX10wRzzJ7JUMTdOD72l2atzANzc4AGEkoUCq?=
 =?us-ascii?Q?pjZRcElOU/xECKxI/OP6tjTDgo1foy8o40HVsd53/L74AhmtutinEBDu3Xn6?=
 =?us-ascii?Q?OKQXMXyuDIC+z6Lp2IkF7fXfIauqNXGJqTDsqdJUaBowINtzu7MaL1Fg5Qmm?=
 =?us-ascii?Q?UtepMfEp3cchTEKJ63mOYdJJ0e2BhIjaiGiNjucQSqeb4ZRvYOh5Ct3Bl08B?=
 =?us-ascii?Q?Rh8k3i4c7m899xKby3wANkrIIl8D1Y6DMpK9sMLe8yNO6KeIRKwDizCrniXM?=
 =?us-ascii?Q?AIQfO7EOqSmVTNYGyyeAQve6+Jim5KCTe/JBcyt075XMoBOm7XLAgiFVIfS8?=
 =?us-ascii?Q?a4CwoD1pYBdJtWsEoPQaVSo9oDGXTuOC+SYzt3CM3Vg7BPfvR8aWVGIVtkCt?=
 =?us-ascii?Q?hJabIvkJ6mg/s+0JOSNfhbAPf/WUOjroV92nqYlncXC0yaLmhnIcdNNnLNfX?=
 =?us-ascii?Q?YZU1G4mk4P9va2cL39wQZzRd/l1XSJprWLYXP/T+P2uVpca7SyClAK/qvCXQ?=
 =?us-ascii?Q?QhPMswLqkWtfM0qOStA+octa8eNsXQKTnYrDAtYP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H3N7HmAhsh0CUVm3TdhoBkmosYjpaEF8yFIjpgGXbRr3ctybXelSnCx2iZDdTJClunz+8Qk9B0ZY4c6qXJS02RUhcklNdpU81Afz0CDybeE6kN1AoO/+idfvu1sNLLdSysPM+wqJUm4JjzULPRQc+HM4bTE4xWrXr7xBGIc/u6Cn6e13qbh+1yXDXyQFiVJ2o8c8p6618DoX+p3Zy+R4cplV80ZToYSwMZTsab0x2CjpnRMOMeaqSaZBTr+dToXRmFcdJu1XyjZ3fGtFEPgVnzHvXbfKxJlhDi+Nrg1r2twFvfPqHtSgJYuEo7Pp7mKa608vCyIy9LHS0btJV3m4IBsNdDJsBK9um27cDoWXl3BO9AjQ2IUBfo4ks58f32Kyuzu9sExM0s7UQ2iqySZ90IpctZBO+7ZIHYNzlx2BtoYCgb0izPdyV2279Rg3BMXWrKc763F/XuD+D6R2aU7lOhjfjZmzZVcLmj93isLCckXO9TF620s1VXXM8pb0VCjR9SPDLyKyuDXYsZ0Ug5P4lKUUfGsXDHaGB3qWWsK0axFz4QxY6s/DVfnAPRutNswoyMf1/i0nuijrDu1r3karhuT5Ew8cBrhd2giTBoC1Q0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c933cd32-9f19-49d0-11f7-08dd917fec15
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:56.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6/xtGcvMBtL6gIr5Ml2b2tIbiZGBuyQSeQHgcC4XSU31BV8zAbdx/rYkBVKGboyIunc9cVwLDZUyz0gFeuPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX0jKhUCJUlqmh hxTJ1hHrr/r8XcNWzhDsttC/OXiRZETiWnTDxWRJQPUDhDdmLI6YhGvdadMdrufyHE5fWtLAgMD 3nTe1uZ+Au5jv/bYnawTgXV4xoGsShbPzWjrYazJSUsm7ROjcDEzSkx/1sFpawr7QfOr/PiVnu8
 dY9L5q8p9nFi2HjIxag9g+2ub4RYlafjFgbAiKpDt3YmOQynxJJFt7a2V86YY0FepOlJ6YFfV7x GELyy0n1FFykNecF542N/aIlJglktQj94bdIpj9iIk7c7wvGeMvQTj6jip3dQun66uotQtxklJU n27oK2nW+uXQ+BCxSITWRdQnBjIFqiho2KVnOX6wSKovl1f+NgR7p6+DdumLVPKcSOoIS72rxiW
 ZVrqyyPHHwO3nZWTy3gvcIXRq2d3PdUmcBnO2fse7ggjtGWqa5x4157D1ljD+APl2myeCxUG
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682238ff cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=72QNezgb5yyMdUjwpC0A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: n792nXxZosstEjOPpYm0BbOruAI8Wlrc
X-Proofpoint-ORIG-GUID: n792nXxZosstEjOPpYm0BbOruAI8Wlrc

No need to sort devices if there is only a single device.
Return early to avoid unnecessary work.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9592c30217a2..704ef78999e0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5287,6 +5287,10 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	}
 	ctl->ndevs = ndevs;
 
+	/* No sorting is required if there is only one device */
+	if (ctl->ndevs == 1)
+		return 0;
+
 	/*
 	 * Now sort the devices by hole size / available space.
 	 */
-- 
2.49.0


