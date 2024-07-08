Return-Path: <linux-btrfs+bounces-6281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D392A02E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6B11F20F8D
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 10:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32DA8062E;
	Mon,  8 Jul 2024 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XamrfmbW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZYm/cP62"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C480611
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434481; cv=fail; b=dFF62GwXW1TPSZbLL9EaW8l83jMeJBFvNEtVpmore4t4HdxzI/18lPs3gGTVM0DjiiWnjADSvwC92LcokA4/MViy0eDpksxIVgjWEHRSnvW4obEUK6S2iTn945C1N32jMhqJSFX57gnX+/D+/iArHGJG8EqN/kigBwXfgICaAcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434481; c=relaxed/simple;
	bh=wM0WiggSIM6Q/hdxfLKei0XUq89Rh3xY8C7vRZphtWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UTxKCzjthP4jPImcZzOZMtjKtci7z+6QdVembJdo72h+uhnlUMlj+vIgQhpHmNqq8vsK60zdLbqWKmk93uPUu3rfNe0vI5nLxnGxV62JikUyMfbeiOHL9Ut89Q11znVrhZ5L5M83i59F+DZ2eaeJmthDE51BZpMmqaOudQ21VSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XamrfmbW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZYm/cP62; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fU0H004182;
	Mon, 8 Jul 2024 10:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=wM0WiggSIM6Q/hdxfLKei0XUq89Rh3xY8C7vRZphtWw=; b=
	XamrfmbWEuNFe3Tt1gIvpH2J5wqUUq6RpidIwPnHdQOeludm0hmJuoK0v6zsAKqQ
	V0jKcXr45wl2ayiMeKbK9MnahX5KtQ5heqdUogwBO/8KwDrwxMvitKSyFCpviBR4
	MHL6dY7gh+VnFldxLSU31QlXk2tObocj24Y5gN5kkTMFqCkuaw74ovCBwvsyzP23
	4AnpITULZCgpMaCeosef1Nt+eIUUvFkmIqHhkbN2Ge6/EV0yvnAf3G7JjQrKwwA5
	3hymAxdlK7d7EiWBCFMCRxTNheeQOdzyPZmFUPRyE5xBctao3WUpxdr+GLbM2vp9
	tEZqsgaLI0II2rg+Oo2r8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8a9xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 10:27:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4689Irr8005307;
	Mon, 8 Jul 2024 10:27:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvbxrse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 10:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb8oJNXuhIbTcE/aXfZqjSnPYvuVIk2JeXKVhBb9srf6Y1i0IbqqoYvC/5AjehVNa5RZ2rzz221HOt0OxK/cWtl/4vzloOZlpQVGcmj2pdd6rYq32oCbYtR37cQsea/60ss93jKUn9kcsRdn2zeHxFN9vNOquv/aYXS8TYdqplqZEOcCWATkZZ6OSBOxz1/L2JcXuZN9Jnwfd3Kyz4NS6LSFyKcfDEiUwIEfZUre2JgH4bM1uhUCwa1zxtJ2Lbd3/mcVH3iOclcWIQ1jE1S7LfsPVNcmxCtC8Sb4J7dfvcUTM6pNrcyEQFaF3EsPooPjVHXx79zdaUcyjQuoGA1COw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM0WiggSIM6Q/hdxfLKei0XUq89Rh3xY8C7vRZphtWw=;
 b=HjpewfPIORDATJQ7QwIaf36mcfHaPaI+CoVAk2Xp5lercL+qZjSHxsX/seBJSH0U+/Y7PHe3l7/HhBOgfILx4tXZ/z3IHZ1diIUiNQ3n5iTITO4aisoLjhOr8AVs3VqVUIKOa/0wITPJM6y9cTooufTsjFlNw7qDIxExB4uDetEiVJGOajzBTXdQFqZ7AeJ3vG1GfhdaDcLlEfKtbzkgELfsmVYSU3wZdNrTx7oWA8e0+4qndOZ0bpe6aG8IP63V4IOpT9U/Tjr0uvk45ELYoI8zAtOsrkccvewByGhx/oHWdQg3XT/7BzZteky2BlQj454cl4m1aJ+cgJs3eX/9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wM0WiggSIM6Q/hdxfLKei0XUq89Rh3xY8C7vRZphtWw=;
 b=ZYm/cP62Wnr0xri/YJB2oaUGrvJcWRc1q709wqw7z9SR1DL1cZIIT86zXKiW3/zF10avQfBuetY4pD/MxrvS8wkob3VCaKi+6Bw6LbHSnyWxk53vnxBQSzJHmu2bVICRKKAVojJaMfb85+WY3Ah/QqLTlldcbqQdxaONaupxTsY=
Received: from DM6PR10MB4347.namprd10.prod.outlook.com (2603:10b6:5:211::11)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Mon, 8 Jul
 2024 10:27:48 +0000
Received: from DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f]) by DM6PR10MB4347.namprd10.prod.outlook.com
 ([fe80::1e9d:8ed8:77a6:f31f%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 10:27:48 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Rajesh
 Sivaramasubramaniom <rajesh.sivaramasubramaniom@oracle.com>,
        Junxiao Bi
	<junxiao.bi@oracle.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "wqu@suse.com"
	<wqu@suse.com>
Subject: RE: [External] : Re: [PATCH v2] btrfs-progs: tests: add convert test
 case for block number overflow
Thread-Topic: [External] : Re: [PATCH v2] btrfs-progs: tests: add convert test
 case for block number overflow
Thread-Index: AQHavQlKZ3kISBh8y0Snp+YJEPyE2rHsxD4Q
Date: Mon, 8 Jul 2024 10:27:48 +0000
Message-ID: 
 <DM6PR10MB43474D88F345AEACBECAF32BA0DA2@DM6PR10MB4347.namprd10.prod.outlook.com>
References: <20240611073443.1207998-1-srivathsa.d.dara@oracle.com>
 <20240612204416.GR18508@twin.jikos.cz>
In-Reply-To: <20240612204416.GR18508@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR10MB4347:EE_|PH8PR10MB6338:EE_
x-ms-office365-filtering-correlation-id: c8530eb9-b447-4355-361d-08dc9f389cfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?/H+dX6hUB9uEAGVl4cxSqeTcjqg3Beefo8iAYdinWuaIysm1DQ9yosArAdME?=
 =?us-ascii?Q?GOqqwUenY3fnSLGHlMHxbUYgJ5CvdmJMKR2Yw2IfVG3ZbUL5Dsj2IOctZJE0?=
 =?us-ascii?Q?sN0nJiIf1R2E2Nb1MIS+6Ro3HOld0f5GwIOU2M/I7ksoBeBDVeeHF5IIYB9H?=
 =?us-ascii?Q?WkJHgtWQRC1rFIRUEnt8vIQvnwh9RempO37vay3E9z38+MW0eWXRwByhuvy1?=
 =?us-ascii?Q?3cgiTwjFjas5EO9HD5dSNWA5uO3s6Iba2HO2C0DmNVzfXPpFpl5GU2JJ5KWf?=
 =?us-ascii?Q?lH9uW43yA2D9bpg4VOaToe0gb0R3U9+7UQEYGgWhvYy46v1XrRG6JdnbMVXZ?=
 =?us-ascii?Q?AsHAH4snoxqlkAEU5yYbHxn0O48vq5KdKNVQ8gj2ONJroNjt/uqoIi4ba6Nx?=
 =?us-ascii?Q?p5U5srDhb5oLFEEEla91shKcFVOza+/U1+tuPaBZyi2EdW1Dta3NXemnxk6R?=
 =?us-ascii?Q?K+wIbLLidZhP81DDEYlskpB9P05v9YJAPeXwv1ZdZsf7AVck0WQuA0shrKsU?=
 =?us-ascii?Q?2r4Wmqi7P+jnrzlC3mRkx3Iq/5P6QwjE0KUSovZnrsyjl9KZ8EacL6QS2jAx?=
 =?us-ascii?Q?XASTby99M3SG9Y5MVcPSb0jSClP6w4PMnYs8yBqoqDwLA/241Hw7s5jpeXSs?=
 =?us-ascii?Q?9rmvkc0t+8qtpS3Iy8JzzT8V73MYuuVaGEGiV0Hw5TXDjyLTZ/oxYzkbgwFd?=
 =?us-ascii?Q?m9zZ7u9czHnvtr4cvsrmY7llMuIYdsKSGVxbMjkLUNRPAPqvC5xuUezLhdpl?=
 =?us-ascii?Q?jffHpOi7+DSD1Ibrm4d5GhnfmOXV5FqfJZIZUYn8E4npT0S4QEBBz4y5tx2h?=
 =?us-ascii?Q?7KquyWXa/mmz44kpE72p234/YhfJ7dOSgQ+t2Ebm2TbbDYFH2U18Ke0i48X9?=
 =?us-ascii?Q?6r8i6RZU2mGSv37H4+J0hsqSNJjrRD/GKYGXBOLWUPdow2bQGyDF9uU0c8xN?=
 =?us-ascii?Q?4jk4sobrCQaL2eygQqAsJHfn9HBY1XLFi8J/1RifwscNnTjvoecDOFWUAvi/?=
 =?us-ascii?Q?yyesZ/J8XFEk0VkAcw+9CEjj2t0r7fezvxtghZ1+gnWSzWrWqSut2CO3cJ3S?=
 =?us-ascii?Q?dVkoRBwM8ahdisqXEidtYQY1t9HccYp5e2wC1F3r6JbtnWmpt1NCxDb6stnW?=
 =?us-ascii?Q?lhoPV/YVnpjnb9ANgInccDKQwX0P1El3Pf4FcMmkPiOnv6qu7Qwz5Ne1HBzx?=
 =?us-ascii?Q?ZKOGQG6KKm5arbj61RV0pawxVt9OX4O2zpYNDO/1DwpKJGUDqxJBp1cALUb4?=
 =?us-ascii?Q?kRwqdExR+B2bmpAjECJfvwPIZRUvB5vrei/GJBz7Yl7CjCSI+HevzYnLWZXW?=
 =?us-ascii?Q?qfTUGkYVDE6eCK/NbGhXBGLXhG+jYompjBGtvN6ZcVFj26rwZ0uQJyL4Lcou?=
 =?us-ascii?Q?xcp3LKsu15Y0+hdo2f+QY9/vGIsq6ZeOp3OoVTrbNc57t6NhxQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4347.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zVUDnoyTK7hUnT1DUtE6dDVTHqfqJVw64WztpwKRfc91E8rj7wYAujtVhWw/?=
 =?us-ascii?Q?Oqj3YfpdSyi8dOhVl+kJflUJZMeKpGw2bAwtJ1xJJEhLT+JpO2uQks74Kvt9?=
 =?us-ascii?Q?SeopowEN5N8iryV4TdjN9Jpz/KGDLB6x/lGhyLTxMgiEx9szwSyRdFvU2LVM?=
 =?us-ascii?Q?dPYtDLc/sB7VUhlTybHsxZI5IwwgRbY/53PaoVIhUN4bvodk80F7fSZm0OLA?=
 =?us-ascii?Q?UZV5s8p/ddakBb9/lMEZp1UD/m4Afa+hP00Gizhvmh32y9RKw+hxvDZmXMxQ?=
 =?us-ascii?Q?Joktw+WOiVvlGKju4vuFv5101atKZ1X5Isr9OmuM9pk99gr1VxskVwTgtAdY?=
 =?us-ascii?Q?vP7snd3K2RcmwTzP0AoCfVBtyEFkDc//UDcELwoh9P5gNdSz0ajrOD/UDcfQ?=
 =?us-ascii?Q?l+tJHF6Tzmu0/LX1NtAbLwGOp8nT9LdHB+xSmQAiUwZuEtdEi74mjSz8c1d5?=
 =?us-ascii?Q?h+Yqmu6rGWpsOeIJcbxvcpoUxGNkdRQCloc8gl5z9eUwJyE6M13MfgxPYezf?=
 =?us-ascii?Q?v6AskmuNNty89JRpUymwztvf6UYBv12WCh5C3y8fxCPwCUDqsefbTpAqDq4b?=
 =?us-ascii?Q?isFQmn6E5v0sW/liCjhhm+6tAci4Pc2CGCLnTp7HL4gAbcJV0TNLr1Vxa67e?=
 =?us-ascii?Q?2SDlqbpe/o7pBeHibkgF9EEqpkdahCIhu2qb/lSTJbjHRmhZEbO5xWkShVTU?=
 =?us-ascii?Q?baDv1aQmacEAByeAxwpcDrcvjenPPjPrC72TraXCl00ubkZ2xvQ1QQ0/Uz96?=
 =?us-ascii?Q?PYREZTa0wv2rpiRNXPGqv1FLZMKDJpbjIqny2XNMAOVwsAfAsu+NGXsN6eSA?=
 =?us-ascii?Q?U/Py58n8bbA6YqePwusTJRuO7b3/gmzAAtMtffxgfLi1wr20m0A1sS8qCY4S?=
 =?us-ascii?Q?Rlo9C6FJSQ3k43qpmNQSaGWiYgcO0AS0EfiseMcE+uzPHxlq4S4FYOnEYfZH?=
 =?us-ascii?Q?Zeq8YiKhekyTu20pE2AvLGxmvQpeN6p2vp11zS1J3eliCqpXBVm5pcB+Flnl?=
 =?us-ascii?Q?9dNpFhOL7xBV4KDXzkrIWlOF/vOrjx7kqu5gC/sTvkBguW6oxGIW11MCDVKb?=
 =?us-ascii?Q?S/FQ56OLw1mzTq3XzxJ49cHm9K7HozWqQ5b8eh5EksonzWOjjs6esqW4lnxe?=
 =?us-ascii?Q?j7DnH7HTPj/f6RKySGHmTwYjRofEZGX/WrK45CWi+65EE9ULF4AtnhXaoRur?=
 =?us-ascii?Q?F0EBJS2roT/f4jsiw8ML57XfdJ4YO1B8uu7fULuyWqB/KvZmXLF3CGTwaYzy?=
 =?us-ascii?Q?u5FLxWgwSZnvyK9BHbKda4SI5HcQpKXSotmjW8Q/zS2VIg2zTdhc0NUujjwM?=
 =?us-ascii?Q?KjSFdUDRvjkH3RClFXe8HqIs/8OKoeu12gK/5QGc/mkZ47hy1DZHTLEEz4rz?=
 =?us-ascii?Q?oLScjxmdO8JgAWardIk2vtpLAZW4f2gqxEFc/tVsWLOTsrV79P9+zE/eBB9X?=
 =?us-ascii?Q?V1HVX3sm9emWqbXPZ8OBWESuqDB8F27vWveOMuRj/+VVBESYwylRaitXWvKC?=
 =?us-ascii?Q?m3K7eUSbc5X8bYFcf0yxLq40gsJ29IYdo7BuOFGqi7jpCMnAxfSh3BWm4aoi?=
 =?us-ascii?Q?6Ev6UbgNpU2ht4Ic8nzj8se8umOooABSqX84EadK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/Bd2+bnQ4VjqN8k2Qsu2cfVqJEMGb4OhOPtwPVWRmaA64NmNznoS6cXPadWM5uMIQ7MNDc/NNeabjKHWfd0qEjWAGZnh7p0JdC9SApaMgQfWMm9Z7xxE489eokSzx0jY+ECCh8OMj8z2EkNfxqCHsTOFl0IHrf8/mAdITm3gpUsTLOHaFNgJb17KlMfdBw8S1XbN8EH3IoinVyLB37rh588WjdatK+ej7zrCs+oMlTB9he/1eVXZN2oUVTfad8GBJaxYtOzlQ9IqmfhX54/Kw1F2gLQ0Nftru1W/099NbCywgzYukPwfvE3mbBylEpFNu1yz6SGJvsB5rZ8pRAdBuJJ0532piOGn7TwrmpWjwyiKsSG37M3rKhAJAUvjq7AABc4AznXMMR+Hj9ldA3Yjmp+gLidHBKS6nUfC+rZcbbR2R1bPSMs+EqpCs4wHuERZw13pBksXOR7PQtQilkw9c8WyTJkGjusFNDuoEb6SIA1ZUaFFjgj5yXRbaMDhGFm45XxWD5kUyZFMwsVIXUdMYgVmvpGMXPbO1xWNwXwhRjka4sTBBHzoKeHJ0EFiCvwRGx8vyIYu504Q6kK0D/lXDRL4YQW2cVrubmPzmt0tD9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4347.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8530eb9-b447-4355-361d-08dc9f389cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 10:27:48.0423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWRU3BMG4QzaElEwMA5b2Y4H8oVS6kBPKeAapSXHIlzmMfZNqoI/6Jj/SgxK2aPyIu9NfNdrHxf3jlOSOswAv8GLfYS7qlBY94pauGijydw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_05,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080081
X-Proofpoint-GUID: _mFsWuFgy3_SIHFnIvhuiUkyMyb-1mw9
X-Proofpoint-ORIG-GUID: _mFsWuFgy3_SIHFnIvhuiUkyMyb-1mw9

> From: David Sterba <dsterba@suse.cz>=20
> Sent: Thursday, June 13, 2024 2:14 AM
> To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
> Cc: linux-btrfs@vger.kernel.org; Rajesh Sivaramasubramaniom <rajesh.sivar=
amasubramaniom@oracle.com>;
> Junxiao Bi <junxiao.bi@oracle.com>; clm@fb.com; josef@toxicpanda.com; dst=
erba@suse.com; wqu@suse.com
> Subject: [External] : Re: [PATCH v2] btrfs-progs: tests: add convert test=
 case for block number overflow
>=20
> On Tue, Jun 11, 2024 at 07:34:43AM +0000, Srivathsa Dara wrote:
> > This test case will test whether btrfs-convert can handle ext4=20
> > filesystems that are largerthan or equal to 16TiB.
> >=20
> > At 16TiB block numbers overflow 32 bits, btrfs-convert either fails or=
=20
> > corrupts fs if 64 bit block numbers are not supported.
> >=20
> > Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
>=20
> Added to devel, thanks.

Hi David,

I don't see this patch in the devel branch. Is there any issue?

