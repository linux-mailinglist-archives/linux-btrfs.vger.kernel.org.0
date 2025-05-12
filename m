Return-Path: <linux-btrfs+bounces-13921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F51AB429A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841FF16B9E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053A29898E;
	Mon, 12 May 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9/x1Kyt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tlGm6iri"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085229827D
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073273; cv=fail; b=rcsCkvBAJqF1Ii1lokIDk86OMDLw89r5Nde8xLQPRIjtScEDzgZ+rrd7azReP7/qMRoLU+gnAtxKnfMSdsc9n3k9IVvtW6gqGb/pRqLVOJBbMbgjQq+55Es0ilcDNPfSAbX8UM3woHnd1OBbkYUKNbRW14wwA45uJIryk7AeGZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073273; c=relaxed/simple;
	bh=da13KwXi2pWpV3h5fZDWA/+LWgYHFFsYFEre8xbU6Ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HJfB1PJVGNtpM62FsT8z/gNv8EcWCXjXHNMzM5Bqw6FNZOYIdg/d4QqpnwJj0HOM0yxzxvSyvw6ndMcGGvdfabEzBPbPq0FZu0LjQXKIMlvG8gkM7JcnbvxICdaB26KzmviZFbpI+79ef2uDwc7n6cQrrr2KNn0/DO/J3KBfsnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9/x1Kyt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tlGm6iri; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0uRR003995
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+HgNdmhIDIFOUZNHnq7/z3xhJvKnE9ybnG5pZls/u6A=; b=
	X9/x1KytfUrCW3FEzceCU5xAnQxiVIb7DvSbycEM0yOb5oH0e0n6+EOblRhmtXR8
	hz7kq72iVO0Xl6MnhN6FtiW/b+3NRENk5wAotQcaxc69Os226b7auORfoFC3g3CY
	LACu2J2wQZ4mzu8bz6pV3zJAhXCMuwqgNn78kXO/9eXtv8QE7ApBUkCW/m4wL3Qo
	L5i/hPwxJf7a32fjV7YbN9YZ/hOjxA2wSqIkT2Mou+qA3pE+QSxnBF+hpgMr34Bw
	g77Z5H9dGmLJcfhj/8TVfOain6ESWUJghjwbisZxD2LcbZSIP6BbIlAUWVBvakhG
	fraAFSloTtc/nrcElSjmoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r354x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHSJ2Y002009
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:49 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011031.outbound.protection.outlook.com [40.93.13.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8e763g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0q9+PTPBUc+AeWQdG8HDEbfAYFd7/1ezglZm/l53pPwdsgKo14jHIUq1qbUO8vjlP892WGrk4spN/Ceok97J/EUMQXINPsCC7YOoXIV0PhHTZkfIWksNaraI8OzdaER1qPhpUr30wCOsAVEevWxZb9lerVplIZcO2Lm5aIwOGsRBJIZ71mTXc298zmm19JqGvYNssItyrDPITx4T4sFr5LemZyzF8HjDt+5v1XuqX5P9riAAClAiFXVbaTjjamcmU3iCJ09md3sxZY43YOs5+vjDFm0Y8Skg+eaeXOS8HGKqxxvcUkaOXXjlPgz/fxQ195cvT4z0l8Ai2+XIjfxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HgNdmhIDIFOUZNHnq7/z3xhJvKnE9ybnG5pZls/u6A=;
 b=TKO1DmFacv0AEs3qP1fa3mvFHa8ZnNRPNHFO0SJnQ6+hMovD/Q80CLcKeTzNoripZW4DoyySeo4gYGahZOeudUYPZCSPZO37UJe52obEBfeCuO49oiXiXyFXirUD04162QY4UAhB47hr8O2sh89x7NmkWLeZjDf3obHqXDxijU0GSypi1PWXkPY6l/YD2t2gM/LNN3mgHoFiYqHRUblx+OMNdWJ+fpUNWatihaKWugfbWa8oyylW4YrHIk8pY3mz9JLpipEN5Mzfpg5t3zOozKA3ApPOiIh5618UexgYO8jyh8T3TYeMu/uEZ+ikgBeah/MtW3GjOnepc95MWngokA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HgNdmhIDIFOUZNHnq7/z3xhJvKnE9ybnG5pZls/u6A=;
 b=tlGm6iri5xg+/Dbkf9qHbw5t2eqlZebB80PFpbuvT8AXons4YmQscqRtzplr442A4KZnlxw9qpQmaxupR/UdXtXZ7Dvw2I2UPiBCb5RW+JNHBv8Ywq1mwYtL3iI7PXnLwyJTnNqX3EQeTTiGkGOvRXAiz4lrV1J2HhIDeB4A6yA=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:07:47 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: introduce device allocation method
Date: Tue, 13 May 2025 02:07:10 +0800
Message-ID: <97de9d30f1827b125341174f1fdcf6e96cda896e.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf22162-4fa0-4b4f-c050-08dd917fe6bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EglES65HqFnaTIMn3HGjpWqSFIHfOtB6sXDQvQraVvA8EMKwLkKjzRIatX3/?=
 =?us-ascii?Q?dlYecxDJzO4YyKB4K6tbo1Oau5cJOPa4vCg6LoFoaMPLsL9rHQBas9LGuprx?=
 =?us-ascii?Q?gKvWbt0Id0GKItrA9y0YZDd6zB3+G4YqAFLaLspeD3IL+v1slljpB0L4eNJ/?=
 =?us-ascii?Q?bDyt4VHCSlZzimL1/HA7ukbgNiNM7JREA1aze2iewoTggo8g8Q7kgri6u4M8?=
 =?us-ascii?Q?ex2Nr6bvBj6beGnYQmc+5cQlP2zvilqNXP7NrU/fnFRIt+oyjc316ZZQoYCJ?=
 =?us-ascii?Q?zJoLkOd3lBDglpXQBOFYklNrpjt8A3Fd5rVuEHNcCLz6wMgcqSQCkhd5gLVD?=
 =?us-ascii?Q?wksONmSkVGAlDtKqdqG9r8qe4JGFACJYUOJwNhxiHuSX5I7hOAnmcX45NzPm?=
 =?us-ascii?Q?wSqESpsz27V15vqXHcc7ZiezrCADPv2jkUxiPwx7cgUt7R8QD+f0Kg1/QoHc?=
 =?us-ascii?Q?qmy8eupRsbJCkBiP6fx7oQm4/RxSRf/venKrlUfDNr1zPU225ly8BUFxTkjN?=
 =?us-ascii?Q?tiRrztNffeulLnO4+U1Q803WRu9PM8FY+kdrLSdC65MuhfC/kY5sZeVnT5I6?=
 =?us-ascii?Q?AiNV4pdHjP8v0FrKMn7H6vgiDR0+yxXuIycY8CGpc48lZRBxPUloqA5/q9JG?=
 =?us-ascii?Q?NDvusb69nWANZ/m1F2kcWezxv1blwcZEz0m8IjlUU89y6OYcIa8Qwmr2GPMZ?=
 =?us-ascii?Q?yT2aREUfCk/GF+Lm3n/KLDfGjthmyVU5JhF+/zruPOcW/F2dSO97vkZafALn?=
 =?us-ascii?Q?ktcio42uXfH2/5/IYy+rWYdOT2UcVzUyhx4vLtKMD6unsj8OJCbSxR4/eDoO?=
 =?us-ascii?Q?M/yiibN6+T5o/BRmAysbv/DT+wSBD1/1EsOfEOqvNtt4CWTzViEBeP009/K7?=
 =?us-ascii?Q?KzxBjQj2LJMADhNM2OJyt4xwGRL30DwFVFHiSCkvbM4MTAH6O46vlvzJuz7i?=
 =?us-ascii?Q?P9YbeLDEgsD12gv576enpPOZFhC5JxdLsoydctNyS65iWLvL7YHFrgZNAwVR?=
 =?us-ascii?Q?/hz5XPQClWRK6EMHjr5g87GpeHvEqXo8f9NYO9RfIbi6+VBnALRkNdgPSOyR?=
 =?us-ascii?Q?5lrHErehkLGJaDbhio2qrFYr7BmSarT90qM9KWnMVIKaUQ9BHrfpceMPyhIt?=
 =?us-ascii?Q?9gaXdGiTFK656FtHrsCCXlIKHyzM9EYIOoWTQG0LCMzfBjrWxf7bvyi1PWIo?=
 =?us-ascii?Q?S5rlALM8AiZYZv8TYpmeMkP+L/MLcxLPJilrYyzpYHx3WsT1kg0ZN0+hNzn4?=
 =?us-ascii?Q?kqjxVgS5YeiEeRLszx8rRmGJRzYv9VxY0j2tgq0ESgVgRKDlGPAwU+8nMJci?=
 =?us-ascii?Q?5qd7cedzPZru1PDs349bO259Ta+C0wMoa0/DtRpqOoNozhXf6vVs1hJ+K6Ql?=
 =?us-ascii?Q?nE3VKJLxDO6M5SYfLK2Jx4w0gsFb+p0s4jX8HLi1E5aui7AVT9QbaUtHIKQ9?=
 =?us-ascii?Q?y8cV1qOyMUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u7xqEEWWqydO3KBl/UABfDEJgOxzs9kdbBGpOQSWtlF9yDSRCyS0ARpK0ahP?=
 =?us-ascii?Q?j7QDCQx92X9E18ikV9D4atW1GcR/5CD7eFYxxcPcwuZF1ICwpzMm83FyzCAi?=
 =?us-ascii?Q?MIsIUB/45NWongxYtmJQts7GPGJv+QkmR4thnftkdVnNea+FdmvamA8QYAcs?=
 =?us-ascii?Q?7ZWYWqa4A9b6cFBk6lDAYs7tno44WdYMBjRujU/MP3RGdAX5Ubnzgm8n1EwB?=
 =?us-ascii?Q?AziFh/swesJFmt3LFi8GsWNdJ3JSnJRRTZrWCzc03+Vm09IGVhCGnV/Gncms?=
 =?us-ascii?Q?6+3ujv0BG1Wl1rOt7MNnwyemkZNenc60Hx7sObPaGD+d7jH6i4S0mp9n+X93?=
 =?us-ascii?Q?1d4tPxczjxCX5pfTky+UjXUu3zfL1Qe5lkjKJkBmlcrrlaIbm1/oZJjFfzYM?=
 =?us-ascii?Q?MXDb3aXkc/8HyA7GJMKQ9gSDh2oryNmGfVgGf4qk9E9G4kpdK0XOdLgVbf+N?=
 =?us-ascii?Q?ma0SmAHzzBAItb5m258Mh0713KZCMQWCwGrjz35wywUmZ0NRZVy2wCVrAhBI?=
 =?us-ascii?Q?g1KskPxl7pJ8rg+qjIAVy2CXfyPzKU/N5K6eHwDsLHXdwYDRe8dsjrHeJsNe?=
 =?us-ascii?Q?JAs1xTvlUw0cW7xQQ2fi9J5JdHkDZI6lz4grRq6NZ42Uk+0rwFgpkdWqJ5x/?=
 =?us-ascii?Q?kg+U2Lt2f5m0vhoZtV6jp9sXbMS4V46szWE99UXKW6Iw9VccIPv0cZTwr4nx?=
 =?us-ascii?Q?APx9o17g8zYjZDdopzv5YTMxACCPGyk3vQOmpCRIoWRT69PLEGnLYoBhVjvq?=
 =?us-ascii?Q?xCnp2vWHoFFcDAF6l62JxKJ+6QUKnXZzIDLK56OiMD8FkIssZlNtCQoQhBcC?=
 =?us-ascii?Q?bdAZ8bQJCJaV2mRIAletUByxm7CEIPmAxb+Hwm7drWYzvqEwgzjK+Tv4VhJB?=
 =?us-ascii?Q?p5cCxgbkcyCxpRRyBdTeDLqd0yL78lSn0rdOE37HdWl3OcDDXsNpRGWBqr+S?=
 =?us-ascii?Q?9ZiLSLnoQFcIApVoc09Yldkm7Nlu/1bILg3oMLomBzqCcd3MMsbMf6WT/bqn?=
 =?us-ascii?Q?Yy6vu6k8hCJaL+SWGGH+aDspZ6xyDkC9ulugA2EfKXOdBe1DN13GfwZ/0a7+?=
 =?us-ascii?Q?lwXS5i2+S6Yd2Kp2tXW5TRDjveiso15TwVBhbn6N7prqeSYickfyU+jD8zCq?=
 =?us-ascii?Q?tfWP7r30V1JzAKsJfp0V9YiEK+9PUXke4c2xUPb/B5nlU8ZcBrJMjObeQINP?=
 =?us-ascii?Q?a+WyLD84j5LvvtyZSf8n2CWm8XYCATwXTHY95a26KJJFEYuqVyybSliFAEDq?=
 =?us-ascii?Q?TDbVAc9kA2nVRU98JCARbe2RS0ZaYXBZ8J0Z1/LZ/4c0dWE8FtD+KBKxxpKn?=
 =?us-ascii?Q?0xIOA56L33gMYXCMONfZUIblXhl8qWVzURiXrVc0QqAsQDsFuJ35GHcDY6hZ?=
 =?us-ascii?Q?BPadJ0BsSpV5gUmt8ArqbUq+qbtrS2a3WBXLp2U4NJHMmhB9AojOo/k63p5s?=
 =?us-ascii?Q?YsC6OeLzLjHsHp6lgFq8CFfAqemIqfd9AdGGlKJ8E/ryGRwlqhiIEqnpCONq?=
 =?us-ascii?Q?jlxCu7J5OSSIDTdIf5dlDX4GCZp4dTl4ggQ3kndkWGkGgrlIAdgrzd9LMeEZ?=
 =?us-ascii?Q?Ic6lTA02/NS7R2EfBEOyEsZGdcxUFNTI5onvGA4D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sn7+q0N6pYymist4u23XA5U/IsADLmhTxbKIqeenb317p8IqCnLORkG8Nx93eqkPZEVBT1avVgPzovFqvsMOpL+pyuIJWHVtFCZvpZ8knPvjI7G5RGETvpf5OWaWdmmQB1IHm6jekn7Abhhn3rPy1qP7liKt6oK6XuG31VnFd1OI7Gpv+DI1HomD/Vvh/e8j+Q8BF/drmHxvypPqwwzSQMpGGTrIFVQ0QeF7HthT065noLybXpEowrZpRkvqfWmSnVQdezZbwXYtrycItN8u2md3K00QRP71u6NWqHVkSrmy/7DPctuOFkkr4V9hpNRWC6Pz8nypMg+XNGfkUNM0FyAyHZLzO+hW+YSP3fhVauFsXLes3EAjEvz+QvaWHd03NYqN7x0vvgk60orMIqEY2aTUq+5Vw+lN46pOTRyR1Jno9UndA3pcpzNvVDxL7EoXi11I4tfwc2E5/foDj5LVPMdoHmBwKpJPT2il7WReifk0xB8XmbFAKoxBtoBJFzkCIA1NrT8Ih3ProAlHaefi0STx5XvmXw/pcu/HZu0k+mz5B7135LUXZNuzbhNdFzc4dQS9CEfuvfdi6kgSwNWJF66ts2lF2tQHvHkJjdbQEHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf22162-4fa0-4b4f-c050-08dd917fe6bb
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:47.6064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLk7Ioe5M7Pliu7/sUfH6FzhAYDQ6/HpgKQjt6rgxVoWJSg5ic2sZNrTtBUuCZ+S6Df37SjWBwLKCIHinlgHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX9LvlHAN78lsm GgHsLf5MOsNNovRXIxLzHXNub3lpU92mCSa93VPOiCzNy19+HlA6tbOzfuAqyqNV9OII4ZJ928I qwtzqHkeopLZVNp6Lg+6DShGkLz+cu16ELtmS1f+ultLTe9uA1zULeR3woqt5OlsUYoa0oxXzcm
 bBca4JXYjv5V9P9CaIe5eJFWRisyo6nBNzQQVbtq5yVg0y/B5JSfXiJCZTvw+Q9MkzDATB0BOuC TKwoisBx57MdLhfc9IL93sGIexDw3Vhyz0hBd/6TEGoqpr4LYLYFQFljCDElzHF7nvkcYHhkuRI W/ddB0ulNZVYNw2NEYxib37OkTZc5xo+IzLmkqCUM/80+Riztj0csYGumtksfGJPFUpEpbWdeie
 HcWBhbvqHcD6teRosbmKHIf1JLFmA3n6rpyPgljLd77naIrTqOXFYs3doYD/zwVrrtVMY8FZ
X-Proofpoint-GUID: fT6Zbhcoang8jo_jwYTsB1hlmanrg8lb
X-Proofpoint-ORIG-GUID: fT6Zbhcoang8jo_jwYTsB1hlmanrg8lb
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682238f7 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vD91PXPXjFX9NKbQv-4A:9 cc=ntf awl=host:13185

This commit introduces the `enum btrfs_device_allocation_method` in
preparation for supporting different chunk allocation methods. Currently
set to use the existing free-space-based device sorting by default.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 13 ++++++++++---
 fs/btrfs/volumes.h |  9 +++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 89835071cfea..9592c30217a2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1256,6 +1256,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_dev = latest_dev;
 	fs_devices->total_rw_bytes = 0;
+	fs_devices->device_alloc_method = BTRFS_DEV_ALLOC_BY_SPACE;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	fs_devices->rr_min_contig_read = BTRFS_DEFAULT_RR_MIN_CONTIG_READ;
@@ -5287,10 +5288,16 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	ctl->ndevs = ndevs;
 
 	/*
-	 * now sort the devices by hole size / available space
+	 * Now sort the devices by hole size / available space.
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	switch (fs_devices->device_alloc_method) {
+	default:
+		fallthrough;
+	case BTRFS_DEV_ALLOC_BY_SPACE:
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+		     btrfs_cmp_device_info, NULL);
+		break;
+	}
 
 	return 0;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 137cc232f58e..0cc799629ccf 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -295,6 +295,12 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+/* Btrfs on disk chunk allocation methods. */
+enum btrfs_device_allocation_method {
+	BTRFS_DEV_ALLOC_BY_SPACE,
+	BTRFS_DEV_ALLOC_NR,
+};
+
 enum btrfs_chunk_allocation_policy {
 	BTRFS_CHUNK_ALLOC_REGULAR,
 	BTRFS_CHUNK_ALLOC_ZONED,
@@ -440,6 +446,9 @@ struct btrfs_fs_devices {
 	struct kobject *devinfo_kobj;
 	struct completion kobj_unregister;
 
+	/* Method for selecting devices during chunk allocation */
+	enum btrfs_device_allocation_method device_alloc_method;
+
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
 	/* Policy used to read the mirrored stripes. */
-- 
2.49.0


