Return-Path: <linux-btrfs+bounces-13930-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA57AB42EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1415B17EE7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C629A9DA;
	Mon, 12 May 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWCQDsVB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hk84ndet"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D629711D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073429; cv=fail; b=iZTuphpBR0/lDpmHrv7BTWbwh/OSHhpSjSXsBl9XKf+ckDgCXTc+VgigrCMT07Rm10gHTmz2oTvpzcIbCpfkNGR7o6J0CX3wxaxnjgr0nAvoLJ0O2JLikKwiMhfq+XfylHrQU+gumJN0VtBJjgk/ma+b7WiCNM3zgzTQaV19UfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073429; c=relaxed/simple;
	bh=JG+FzZxFU/goc3vCjz0VdfQxw2S7wx9WLGkpInvLTUs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgJAp2pL2OXT5e6c4ctnkKLXEC6QhkPV7DNF+lNPZU/8A+/70a3Ry5Rumvq4RDHu3NTg6o4D+utnZqwzF09v1cJjL4puViRSnow//TRY8jN32nAhkeCgcT01cZbZdt4rP72M1Qs7NfJWMbbELg3FUB20gAzhtyXFDz2PBTsGJq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWCQDsVB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hk84ndet; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0raj000526
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=HtkLV/qfim32SYkwEJBjfXVuPmqSTG6vGuPxbIDXJfU=; b=
	RWCQDsVBjLDcr9Ozwj/a/hXcCO+jFiQdYajnJ7hUnnY9eMjJHjr4OrDdpJsvQX4E
	rtwx4gPBlEYRzDE7Y+Giv8RkFbyucGdK5dQo2QY8xYjwW49+C70rBAJ7wIpJO57S
	D+D+FlnDboWkWpevGo/1NjrnVBZIxoCg0xD5ZRAMk/8wHBwhOiKFVVadGJT1ZCId
	nFjpU/UNBz7881rEPJ08XBywSHGy8QWCA0p1i/+Q5bYqGSvRCcSiB31JiLzKwzo7
	HilkaAEhZbd+p6FtG/kuxW3MNd5P79gjZ6owniQXsH2admzGTED6NPGh3SsvKCDs
	A/mqSQNE8HC9ULNOj1QrxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j1jnk6bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHeaaI036432
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:25 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011027.outbound.protection.outlook.com [40.93.13.27])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q5y1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:10:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrERtKQmJ7hA5zrVpxDWycZbHtP++NgbsxnNj3pEWQbBmWEX6XEBaW+EaAoXW4hKCVARu3qOSXOJzlCtl7MHhi5+mgu9M5H5DGdG+1wUpLK7zcuV6qIK97n4nHiqQ1DzI/4hFYNUPWEkgBvLL4P+CMXUjPMeA64e3fmvyE2ZLFokxPYx34MVcaquX80OxswlIX0rV85ZdwVK0cDWQr1zG5F7rTNyz7fipxThZNrpLFBObaUmsET8rAZ4r36YJwptwJwe5hXzNL8N0JEXtEraHysbOwf43yl3zi7sojEdVxdaJOvAjc8Rnizq87tz60Manld4dxGIAx8UlYf85bOedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtkLV/qfim32SYkwEJBjfXVuPmqSTG6vGuPxbIDXJfU=;
 b=aVYwrEIH9KSrWHcITfsI7yXHsjp8I0ccxBrYbN7CVg3EP8fra+CghoJjZTxXhxcgzW88sYhzegabPnNj6lPFJYV1Jm9BUf5HEYxsiPnuGWdywQoOKHeECWNSld6vhhPCF5cYv8ira2cvDod4Bd2MoQrLuNMGEwatY/sbNaPVLtMvbdu7C2GKG4rgvTddDaGJeXlALi+PM/AcogUfI+zpDcshPLY2UtcVaNppctPZEJ9f+uMVgYV6UjlVUjNw/BCYh8qUpShdbj+lvrTzULs+LgvRU+DqNI/ensvBHKznU8AZfR6jYRpyrrvjUdLEx72ItJ9PKJAad2uFGcDTYhX0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtkLV/qfim32SYkwEJBjfXVuPmqSTG6vGuPxbIDXJfU=;
 b=Hk84ndetM5MDlKW+LTSlWw5gcl5wrSi0PHBPpDuJJiwYtC/0YhANKnyPyNsCw6AeZQTsZHeMOiVOT1U5u3OyzzZWt/WWgntJvYfRJhWSgDr4erLw28HM365zSBcRB1PaUH0+Deo1wDS6azp9KM1J1Rl06mFcV7RvSSsCfmW+gNU=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:10:23 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:10:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/14] btrfs-progs: refactor devid comparison function
Date: Tue, 13 May 2025 02:09:19 +0800
Message-ID: <a30ac45fcc25926ad952b34af48431dce526289b.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 460a5b02-ed3c-4be8-771d-08dd9180438b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzBB/ZIXhHAEcYql688pnhygomh4Y5/2I1GCVyJ1WJ3J5h9NHQv/lUHjGtVa?=
 =?us-ascii?Q?vfl62PR6MeDkiPTQjLBU8cwuqU0oYkmE/8ieRq/9iiohdsSCq2lF9ycV6EiI?=
 =?us-ascii?Q?oMafY8Y95+LuCn6I6DP31ZNfq6+6XRIjvonNl98yCU3ltA6jcK0DJlfhcW3n?=
 =?us-ascii?Q?UpksTDbC7NEHbBwSDv4KsmaYXkNJKRoMae8BK3GP1yO2UX/q7FEV3X5fdmgO?=
 =?us-ascii?Q?cRWSm23jvFOZBGuWKjxb39YM2hME6BGdMujN/58t2OLN2vqnC4jpaa0bl5L7?=
 =?us-ascii?Q?nXtsl5KcfwerYQVtkq6wrpBeaPLLo/kPSwvcY94oJ823sbwaII48KHGTNvIc?=
 =?us-ascii?Q?g4OASXt2RusGmlBrlFBMDQS7XxB/hIInWluVlFjnPXSCV4lZW2WdhYhsDjHH?=
 =?us-ascii?Q?hS1hPNyY7DW+KhCWz8qCsU1b42cbaqODSMnIK82cIAQJQxg3iW59Nerw4QZ/?=
 =?us-ascii?Q?ZZZGROwES+hS5yewVMqAKYFWFS8SEHeRZSyKRTqQqZvJrz8t/sX+pnqtl/j+?=
 =?us-ascii?Q?X9pw0e3X7uqEwRb+TUgtxRz06m+DcqHfaol0Y+Jkb9HWYjV7UIWd537mGE+t?=
 =?us-ascii?Q?cQxIoVAcNLkEWot+NNnMmEuBjJtaZF/RcrQsDLCwCt9x4A1SSyghyW+bxrgU?=
 =?us-ascii?Q?x4zu9p/nRSmMxUWZRkvyvYXLIYhbU5hXP/igYr4FBFVcd4MaTcW/zvbxU7w8?=
 =?us-ascii?Q?/DD92Bk/gnnAdV7+4vJsgtgOKbPWh3RG6LIBFzCNNVOp53sHwdzqAzvGh1OE?=
 =?us-ascii?Q?rJ3+kaoN8GPXcYwNI6x4CGyBo+/78IOIFKnBJnED5aFH5d807oI6NYQ80y+l?=
 =?us-ascii?Q?ZxI3GSJc5mSt7IZO1oyN5CgCmo+m/GyvIJLoxUvO7WkmMW2qoxpHPv7C9vbA?=
 =?us-ascii?Q?Xqbxu6Tb6zpmVzdekd32PSQNDwii5X5UecvqR8Ei9MPwDNjJXM9VJ2r+VgsE?=
 =?us-ascii?Q?4s3B+5Rhahd0jO3q217mcUWM+SZuoM7YY4YuSamEVR1Eu09FS42dHYV76vgv?=
 =?us-ascii?Q?0LTZYSSpqinyJIq1YiYNA183sL8/5Eq6KNrCvs+M7sCbvIjkUSgINsIO1JCa?=
 =?us-ascii?Q?MdCMhuGRlmoVjkNexWy/jMSy1ObdQcdqOJgd6iv2HRchk0E1lgA0a/eeBcbr?=
 =?us-ascii?Q?jEZJcXQOTyccwjucvreOM6wWujs27ZPGHErX9ffz/0Vt1k9CftqIiFfvqO90?=
 =?us-ascii?Q?h4FmmR/Vaw0PAMiUGKD3KaGki6v4i1jExScQmX4LogUpTcCTXNxITHSsHe3W?=
 =?us-ascii?Q?X8A4ZZuvBrHN82JRVNbTZt61mW/KHc7HNkyaXhUPGoO7nFWor0kzGty2LQTD?=
 =?us-ascii?Q?qWcuhoAA3yLnGwPpvLl/rQWf4EbuEkD8evBV0z5yJepOGdvHS8e5pSw9p3Ff?=
 =?us-ascii?Q?lUpQ/rsxZMGUJ2eZDkiPB9xtAa+a3ImYkQyhymDhYxbqKu7yTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AfeLqHO7H/NNtqNQNQEisFOOgf7+3qJmCHEXNnKMMFETpN9/O2BpGWnOwxl8?=
 =?us-ascii?Q?hrR/BiBBvi79FHtVNHbDDeQvJq+cg8N/245QaZu7jdxD9UXm5LeJVG86oLHt?=
 =?us-ascii?Q?jyGuGYk7U6CbTA75Kt3+gP/4bNMSQJ2kdrieyrKrTBgAXQy9NRdA99UL9ckH?=
 =?us-ascii?Q?sC6zX043e1UUP2mjKjaZMFdC6Glw8mxNjGlvL+NCv4RCo9gdGnKVcAjYEy2B?=
 =?us-ascii?Q?nQd0Fu+2EsUR1T4QDW7XjOop7AmudP1SNaO+IPsF+fSpa9h81GBmDxSyYXih?=
 =?us-ascii?Q?VS0kcxXgJ9AzHbCD1/NwN1ZPiZlJiAYmr+VIC1QWUOzCvcJIgtzI0QFaI3PY?=
 =?us-ascii?Q?WpTi3WdznkBPQUV/Y3XsIAq/YPhl5ASO7hPAuXP3cHA0Hil4bHxvLZpqdjoY?=
 =?us-ascii?Q?WH5nSbIt+A6hQtNBeRGcl8vCUUysHMRWDQvWHAnknvGPpUnRxGhIoXdUYEtj?=
 =?us-ascii?Q?j+4dn7qkOvmGn+3s2tzKjttzQjE+HqGCLPJ3p7cbw/IqE/PjdK408CfYIqjZ?=
 =?us-ascii?Q?eOYFEwWDZnKBJTRzrwcyKIIA+xpy7jti8o8W3/PEH4iKUpKNlTBAiXZCpJs8?=
 =?us-ascii?Q?AowxnJslXpPMmRPEV2dclJ94LNnZ7Jk1oXtnhMgwrIt9p4zet3SaJ84ILg5J?=
 =?us-ascii?Q?gX4P87jr6GbJZp5hbEgcQJEF5Y2z4dFN2O4yomODUoIaqy3AxE0W63ELjvTL?=
 =?us-ascii?Q?1rXJR8lM/IN5cntt/ZzrRARrCI9FiGo6ka1zHfeVLFJ9tRi2jdhN2FKAEo7j?=
 =?us-ascii?Q?PUWtxIV0fWvG+n5E5rmkG4RoGl0sv0Fy8RxXxPaRL2wcJh3noBntzL1vkzsj?=
 =?us-ascii?Q?tWq4q/qM+1NAQLSNGNu2fANvGHl+T/1jvNO9vU9CYnAE2KgC3Ny994wBJE8x?=
 =?us-ascii?Q?2ML9Timso1vni00+OT6bIfgyFkoG73iBRMXEbsQrQFXksXXHuApMeAfb71i1?=
 =?us-ascii?Q?K7uerEICtJm1n+zf1qwFcBnhDGhGwaAcFzagsUEflKIXylGpGE+bH2RCXr7U?=
 =?us-ascii?Q?mHCswcxWdiJG21eZ9/5bmhA6e2lLZUdptmi6/jEI3r6A2ypRjDgKmIO2u3Y4?=
 =?us-ascii?Q?D4PBoR14gm9EFoYts/oBREGniJl0+JWj9IfKIqUoEV2TAtsw5qIGYVKEA/VF?=
 =?us-ascii?Q?OstUWerI3DwocqnumRjyKMzljO+8pFMeCE4FLOGdC1NTsctAUc7gt0vdPOlZ?=
 =?us-ascii?Q?YtmlsVtH0PXH2uRktyGCUulcnZ15yTQeae5elBCCF+Y8ViSMzqTzv4/PWPua?=
 =?us-ascii?Q?MoxxmrjCjKUHv/DZlbNKzpoE1OIfLIzEiRYd4kHT/NMORsOsf5VF5hYz6eDd?=
 =?us-ascii?Q?JOPs0pIiWoQp/ciW8x9BMOWTc8LKP+1eFtxHaPP+MVaC5BZFKjuqmtLWqCFP?=
 =?us-ascii?Q?fmKk/XWNRJQff+aS20p9dUq85eL+j9L13zT1KNKoZcWtJOkTR4HLFie9ri+l?=
 =?us-ascii?Q?+MVx6pYsIjwYnZF7qPCcNTS0qOWLls+edG+6gYoFU2rFNvugjwp8wEIMTsVI?=
 =?us-ascii?Q?EMisqUE/JHAyyWbBCG2Kd45/rJ9Nx0mgW6vVh9NP1g9CQzBpjkwa67Rj6CkX?=
 =?us-ascii?Q?091UaedTI3+Gqcumma7qlzZtYUnH6lMdZkjodvNw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	htU3jgdknBZHNlq2N0165LG6VFtL1dLrICuNAm8ej9C1iYgomBEWiUra4CdDu1XlCgXAoBP/WBxa8wVCwGOjNBa8oj9TKCDLdzw+7jRkP90zHWTZoVubk0D0kBY3pre7p/JmejbKZBVeMz6MvUnGWTCXFqaOK/h3saAZyNrhpLpF8YS+PEEspPrqyAOd7gbrQYadb7fPz2GCfEwWBlx+D5l8cihVCGs3ZSBY84qiKK+dzgBRttkZ5gmk4I20DI6QRQeSu0hFK0MBbsyKUr8h6SnwmHo/kuk+elucTKoe5ZuOgOF2MKczwOF2PdduPLH2PaqI6NopyGznJ3bc1yQm/dyw3LwfbrRIepXpGhhLtLtDkUm9Xr6C2zdGKmJpVSlmvthfE6z8Yb6pDVALRukVKlqLOvGC/Hez9XxddNh/jvNCgKrbB+RTwzQgNFysrreD8Va4TLua6R5MGxSU4VPC+Q9L5P2T6legPd84sXWUNrE+nmH05VyHZNnoO+uNuy/1USUCbMcCe74KPgri/V8H2eRvsZkmRTdsP3o3YYM3mAoY1+r5L7b2/0rVlqA4IFGmhLVz56NpeLga3jIvwoby6J3jeOF9YTnN9qD6JMEcphw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460a5b02-ed3c-4be8-771d-08dd9180438b
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:10:23.3043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ix5d8bYN4eALcYPRmihMHMzCkoNnMGGZr3neIfSaQPX5pRE2+WSdPfA/O+zX/TlDn7UDY0QcejlBB56UTLqUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-GUID: l7dyU83uzGHm4Bbs3Q5nZ5MsmcSENLV0
X-Authority-Analysis: v=2.4 cv=PeH/hjhd c=1 sm=1 tr=0 ts=68223992 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=sl4vNpnTXrvJ7Iyo2YYA:9 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX458ifaLGpFxx kBB7mlhYerr6wUMvvd7QgW2SP+FiKgfg0BEULmhY+2ZpB1R9D5BD2Mab2dXLpWf67vlN+k+OkT6 0iegejST5jLyb+JsdwZKbi9VWC+S57ZM3XgpHsaelXrWxhwzsyFx3i+8atvYy6Us1K+joRb/1gE
 6YP5AfVQ95r7CDHqioEUl9vO1jBhxcu7L1Ypswr3UIvLEDvywi/h5GAUKQhDTNM0aUsC2LQIbYW iR/0Wzf5RebeeyTwp5EtlDnDzBVeGD6N8Nppxq485D1Uv+nfSA4h0mCVjHP8nYBKJQxiY6Ct3ca /cjGySgbb7UlSFjPNS6lYCMgXTgUFhC9ObK61lLbiaJEPSSntweCEwIp+mnjk8ZYbIqhIQ5XgV7
 ZoIdyECuZikvtFt41+QHf21UCp++PLoHDmpNq00AQbKRNJnQZ1SD/bomq9oz0t+ukMFxU5Pi
X-Proofpoint-ORIG-GUID: l7dyU83uzGHm4Bbs3Q5nZ5MsmcSENLV0

There were two similar but slightly different implementations of devid
comparison functions: cmp_device_id in filesystem.c and _cmp_device_by_id
in mkfs/main.c. Merge them as cmp_device_id in common/device-utils.c.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem.c     | 15 ---------------
 common/device-utils.c | 12 ++++++++++++
 common/device-utils.h |  2 ++
 mkfs/main.c           |  9 +--------
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 64373532e5e0..54a186f023c2 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -259,21 +259,6 @@ static int uuid_search(struct btrfs_fs_devices *fs_devices, const char *search)
 	return 0;
 }
 
-/*
- * Sort devices by devid, ascending
- */
-static int cmp_device_id(void *priv, struct list_head *a,
-		struct list_head *b)
-{
-	const struct btrfs_device *da = list_entry(a, struct btrfs_device,
-			dev_list);
-	const struct btrfs_device *db = list_entry(b, struct btrfs_device,
-			dev_list);
-
-	return da->devid < db->devid ? -1 :
-		da->devid > db->devid ? 1 : 0;
-}
-
 static void splice_device_list(struct list_head *seed_devices,
 			       struct list_head *all_devices)
 {
diff --git a/common/device-utils.c b/common/device-utils.c
index c39e6d6166ad..783d79555446 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -641,3 +641,15 @@ ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset)
 	free(bounce_buf);
 	return ret;
 }
+
+/* Sort devices by devid, ascending */
+int cmp_device_id(void *priv, struct list_head *a, struct list_head *b)
+{
+	const struct btrfs_device *da = list_entry(a, struct btrfs_device,
+			dev_list);
+	const struct btrfs_device *db = list_entry(b, struct btrfs_device,
+			dev_list);
+
+	return da->devid < db->devid ? -1 :
+		da->devid > db->devid ? 1 : 0;
+}
diff --git a/common/device-utils.h b/common/device-utils.h
index 8e96154ab0a9..cef9405f3a9a 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -58,6 +58,8 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 ssize_t btrfs_direct_pread(int fd, void *buf, size_t count, off_t offset);
 ssize_t btrfs_direct_pwrite(int fd, const void *buf, size_t count, off_t offset);
 
+int cmp_device_id(void *priv, struct list_head *a, struct list_head *b);
+
 #ifdef BTRFS_ZONED
 static inline ssize_t btrfs_pwrite(int fd, const void *buf, size_t count,
 				   off_t offset, bool direct)
diff --git a/mkfs/main.c b/mkfs/main.c
index 4c2ce98c784c..b23d0a6f092d 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -508,13 +508,6 @@ static int zero_output_file(int out_fd, u64 size)
 	return ret;
 }
 
-static int _cmp_device_by_id(void *priv, struct list_head *a,
-			     struct list_head *b)
-{
-	return list_entry(a, struct btrfs_device, dev_list)->devid -
-	       list_entry(b, struct btrfs_device, dev_list)->devid;
-}
-
 static void list_all_devices(struct btrfs_root *root, bool is_zoned)
 {
 	struct btrfs_fs_devices *fs_devices;
@@ -528,7 +521,7 @@ static void list_all_devices(struct btrfs_root *root, bool is_zoned)
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		number_of_devices++;
 
-	list_sort(NULL, &fs_devices->devices, _cmp_device_by_id);
+	list_sort(NULL, &fs_devices->devices, cmp_device_id);
 
 	printf("Number of devices:  %d\n", number_of_devices);
 	printf("Devices:\n");
-- 
2.49.0


