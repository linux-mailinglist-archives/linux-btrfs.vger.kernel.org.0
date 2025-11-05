Return-Path: <linux-btrfs+bounces-18707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 818ADC33E3C
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 04:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 825584ED9EE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA9326F476;
	Wed,  5 Nov 2025 03:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M1crXoQz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cN2SP8b0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8724A076;
	Wed,  5 Nov 2025 03:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315039; cv=fail; b=PZkPqR6H2P37g4CO0UQ4lCdwm1y9ORLCa3UAyb1uEa5KdeMGHtDZJ4PjEXm0zQIpc7PDrvfMRVQZS6X6Nq585oiriQ5bTbXwely8vEnVTbYJe502ma2YI3UWK66rVPN0nMi7Lk9YdGnVcH8ABGXKdwJzHjEILJq6OX7w9once3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315039; c=relaxed/simple;
	bh=HmBrMr4RQrlMrtpqjjuXuatIdM7rH8Sboo7bWpakm08=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=o2/tDm3Jj146l2YfWoGbHam2xdl75rzpESBTox3802RiSfzNZiwGitVSO9PstWeDctu2ErFUmapkWhpijwiVibmUCXfqkq43qM675+eQshRJwejavV5HByQuQr2MktxgDf9+vdWYHQwZmpgKo36ToqHwPeYb8IMSjGMAXUahMlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M1crXoQz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cN2SP8b0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A53pge5024898;
	Wed, 5 Nov 2025 03:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QkIREqPgJRtKbHEDGL
	JQQMuCrdP3JnLKyWQoVyKZDiE=; b=M1crXoQzClwevCZ2idoU+xL9wnjAhjgx+a
	608CNsUJ1f/F7D7n4WR6lQD/AHQMrPCabqso08Lhs8VITWUf2DEPSzNexCTfDGAN
	nznPX8UkHgDa+82fsc/1fEDk+/ctQ6L5MQ8NoZyxNLDqupiV6DbsP/Mk0c0YbksA
	apd7Y9W4nnhLg9oBV2a6uG+OX41VTNNCDVJ08Z0Z+HzVwIP0rDE1SXCBOCfxLTew
	Jjg4vhkpkOuY4MwnBKVtPnbDzQ92xhln7suSo+wtb1r0maqpTykJQoBKm7uEgrV2
	gLuNFnQFqov5pOeS6Cmg46y4EBueP/WbHxgxosNiyQhxRcTaXa0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7y0wr07j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 03:57:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A51XG9E038823;
	Wed, 5 Nov 2025 03:57:03 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58na78m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 03:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEgJB5b7Lio6ltpqjibBlAyK7XCOtlMzEgE2dUVaT4f4yK1IAwfz9tupuJxN0YSiz+Qu53x+h4KnarhjmDV278COzBfZ1UTO7veSruoIU5InCmbAWpjfnHCTCWcziGQzOGdhmszaNen5E71pvcwdSlX5+TMiYWBqmAZk1sunnRjpPvluthqv3CD6cqbA93JYXXbQr6qiUrIbYoT4VS4jsMq9n/YylcD+8QS2necaEezKVOD6ceUaTvwa2I1sAn0HUhFwY9hlPJG6KdA13B6BJtXkpUcW/XiKiQdaZ8mN8CT2nj955rToXgZjaNF8XFeid6PJXsPXCCcdfeLIrFzQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkIREqPgJRtKbHEDGLJQQMuCrdP3JnLKyWQoVyKZDiE=;
 b=iKfcTu8hEHXrIMmsJeu89VA5bWfAcRUSfRiic6GNvSpZeN0Ouy4a5OOqU8y4Akf4qtBXJbEHGn/wpCEpXUsX3+6ugBl4mwKa+n37wsC7Fuxztc4+JY5S1gaAiSbu5E1cItTGCVKSLJn+XGEMp4lVbMV+35ujaWPn30fjyKLNIUpZqLlZEa9WEoH9U5MwbqJ+5rSMa8HWGkMVLrbGe6DLyFTs6fcNiCia0j4BfI+PQXPUHMDud7jvr4Yxtx2D23BN6XXWA8GWVU8x+4yHaD1VQTbPngjoYc+ADiUarZoyOTxkMe9kWqqqIKuFjJOfB2/Mo5Fnhc+lp8NPWjphKuwLtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkIREqPgJRtKbHEDGLJQQMuCrdP3JnLKyWQoVyKZDiE=;
 b=cN2SP8b033Ng6h24C0JecgEUmfF5WJQkmcJ1vN/S2eMAAdYN9TAvjCpBgIv4uDez5oDe6YG0KyYlQOlJlz/rG8oRoMsagusdbVdkge3xYfrj8ElPZXOivpujLnhogjqY9ueqIjAzfM5dKGrxEvdKrYoInPxvOVSNoNpByxzHxw4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 03:56:59 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 03:56:59 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
        Mike Snitzer
 <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "Martin K .
 Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v4 00/15] Introduce cached report zones
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Wed, 5 Nov 2025 06:22:34 +0900")
Organization: Oracle Corporation
Message-ID: <yq17bw5p1xl.fsf@ca-mkp.ca.oracle.com>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Date: Tue, 04 Nov 2025 22:56:57 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::13) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 373bd1a1-0cf0-46b4-f999-08de1c1f5ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?36gwtDmkB1WyqZzbA/p24BipKd5b8rXdD1laWhUhQVeshhoOqH7APyNzRnaq?=
 =?us-ascii?Q?U4XLLV9nYtJ2/9/nBJpep0FrFZASUoqbc0vEf/4NgtJv/ZRr1s5nQD1AG3Ag?=
 =?us-ascii?Q?1R5PaGtnAYw0O3MfqY9ka5YEG7ga+ahFGcLblWp1g2uzeQib5waxBVyJHU2H?=
 =?us-ascii?Q?FQWXO4Iq0v6HPihK71Y1OBtdw2E779ZBCqqFuOducBc+DFIWbmq4nSP4OVL2?=
 =?us-ascii?Q?I7CURGI6qCwRgzWI0RuTAXrV3VTFT3fH+bSWP8wnlLhb3Ix5ar1Ez2Z1DWiY?=
 =?us-ascii?Q?KsbTpmHiaWdbzPLlWs5aurYEMBDzAxfWxZFBUQUhClJIsjOtcnTBk1t+3U/D?=
 =?us-ascii?Q?Ub+mkclhKhDYf/0D5G/E0DJMvwZ9ppqdaNKw0B0SwVWW+vAY6iaCE9lK7kbW?=
 =?us-ascii?Q?63e3buU+ZaetjIRSRXyHtiM/3SRBh7JaIfIn2NOmlq3kA8Q79rh1n2cgYUk7?=
 =?us-ascii?Q?qAggLp6zQsqkSojzQAT9k6FSU94/+7DkQDxShooQmeUqrCUgWf5W1r7kHbI2?=
 =?us-ascii?Q?DVH7E3Wk/mkLq/zGY66HYgMANMmBfbaOOT4ogcOQvAFy2Z2R3XxgD/9qGgmg?=
 =?us-ascii?Q?qhCfKAujTFutufSWfSY/1CnS3oA2K9Av4F08ZladTxny0VAWCP8WjNzewt22?=
 =?us-ascii?Q?m2jq5g2NBIu34zbUbbz/+mFk5DO/XkmjCzs+oBxVLNHqYn4do11Xz4SLv5R1?=
 =?us-ascii?Q?bgAoWqd9NB67K7xExtkrrUEHc48gFelYt81yhgErR0yrh/dPwWPF570cGdpK?=
 =?us-ascii?Q?rcwN4UNrT3+LfKyzrKp8Wjyk0gNt7YnLpLAwK8SNzi3Ui64cyD9zuC6m/3Kc?=
 =?us-ascii?Q?fesk3cNfEdDiAiV3Y5rFenNsdni14ehjDqb/SZR0YGOkqzitDE+zJQOe6fOS?=
 =?us-ascii?Q?vOM6TbsrWbfl6nvFlh4TPED0CvUKT7YsMjD3YkJBQrn3lu/JTj9XhodF3Y/6?=
 =?us-ascii?Q?/y/xSSAGwDQp7Qzvpi5CTdSkwOaPbufnMySi0HHurvidX6yIw+pDFZd+Z6Dg?=
 =?us-ascii?Q?wgy5BBDgN//aSXvLSpLCbxn9tUSEGXCA7xz/2i3rHjinv7gZots4MvyZt5fY?=
 =?us-ascii?Q?xw/5y3Xf6/MEzlv+80IF9LBmtpBLqAALOp+qvgrVdO6axs0zBJDX/9lnBTrB?=
 =?us-ascii?Q?kUYqVUH6+U5iOHuwo6NDQFlVPRN2AHo9E5taeX8p/cTmmxL0F8bWiOYT+l95?=
 =?us-ascii?Q?xcGrmSGei2duDwFaeQdITGwhotEmowdrQTT6sKBIpWw8vDzHe+XFy8TBRNgM?=
 =?us-ascii?Q?X6S+NPYffs2TeLJbgEYODvnyCTNMVXdHejFVZki7IjnTd2x0oQU0W1a3CVC5?=
 =?us-ascii?Q?5WeWNope8fYsAcvky7Nh3EGM4oA9NBudJ9UlZNJp3wuFHgT4yLk1jQrcFmEv?=
 =?us-ascii?Q?UvQgne4Q0/Jw7gmMhU/xB39ZoTbdTMIGMMdBFqOoDaEzU9UM1zWkVRqdkIYt?=
 =?us-ascii?Q?CrFgaHlT+8dcDOeWUejAcIJ3Ua8rHJ6+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qwg0MRSZduNIwDGgb8qnp8o9ca1GH5OG26qOUq04gXhYo3+Md5e85sAh/HNt?=
 =?us-ascii?Q?BaR6C6kzZ1tME3ABpn75q5tfhO/+ruUgkUi8bp46Z7sciseOBPOgQCprSSZZ?=
 =?us-ascii?Q?x2t/3XCn7CKEUL0Euc6qegIFAsvG8qNfKXfwjFFwHbTukfTv57exeWBDcEcn?=
 =?us-ascii?Q?TTlakJToGLpY+MXO1D8HzTwYJOZyWYPqMd7CRxxF4oaEw2WwehkEaWKyuUTP?=
 =?us-ascii?Q?sjobe1+AHldzqK/4znu7K5WrAHbV5w8MdgZjED5GzqWkZ1HfXsQVSjcaJr6U?=
 =?us-ascii?Q?H8pHhYZIOJcFD+aV02YC3sYOD08ZOCAcNOGa4MiNOhUlMUlEMJt1g8e7zh/k?=
 =?us-ascii?Q?Auyo9L5cmL2h1tufZ412uc+fQyrzJl5cAWcalbgDoJbhArmGaV8nXZI6+B+c?=
 =?us-ascii?Q?waV60NpUHkCRgYhvivz9H0Xc6hy34m9xgVKc4CdHldPDXZ00wKbLbnmKMUMO?=
 =?us-ascii?Q?xedSsooXAgM8YHrOsgOgn7R16QraS8JMQ/d3n2XSxN3wwADGysCwxFGyYIc7?=
 =?us-ascii?Q?XtE5choGv2Ci26hyKnBMFq+AGm4+wXqZMkgt6cCn68D1mHia9qmIDB+y7E0I?=
 =?us-ascii?Q?syms56rV4/Pmm78r20leQtbZ/H0aEdMos26bU4qlghiAMRrLSJ/0vjLmLHsk?=
 =?us-ascii?Q?msi0/PMsuB+mFhyivdTe1nIZGyYrEnU5+XcOQGpSTx87B/hFujJz8pOi2/Wm?=
 =?us-ascii?Q?9JOGgDemPbFy8uglRWbSz2dscLxBaCnmY5gNOYvqC/cZ+4QLndV54FvOnCNx?=
 =?us-ascii?Q?F78bPzaK13hfYbpk7dmUoKrgepLzH4BRoBpLVfFNToyelzokzn1VNTvsIZwW?=
 =?us-ascii?Q?lkF/7F+ocySe/QsZGv4A/rHY6D4iiXOGk80cAkmuo3P8yi6XMcomWf/ByjcW?=
 =?us-ascii?Q?UoIfXuuTNVdrOYS6gh1CXfTVMa+OKUknnQME+mK6Q/iDPg08vmUACINNuIkr?=
 =?us-ascii?Q?blJDVPBtfUV6/RpBa9IHbYN8PLAglcfmG/ZOn78Ie1XXGnS4C63neGFfLts3?=
 =?us-ascii?Q?CKKvMwJTY50v2svrLUnf8wd/4T92OEJK2974RpifR69aPfaWbv2mewzauDk4?=
 =?us-ascii?Q?QK9iocey71jC3F0a6FttcWDy2xthx08FWUxSZBUBZmwvFQCB+S3NLo/m8QOB?=
 =?us-ascii?Q?/flhS+B++nkf0ijegVE7LwGWSh9DflsqYIriiM/qpOYvYqRMNmiN/AGvx3wE?=
 =?us-ascii?Q?5JE2y7B/TPc/daBRislswAgNg6xDZfD+JzP8EkmmBhxOE31TKt85HHhVcJtH?=
 =?us-ascii?Q?4tup6mrcqNdwwinCU0vdjSbgy4vBAfuGWCeSCS2Xd+Ak0/PwKoJ8jfiDMY9U?=
 =?us-ascii?Q?lDnYdgYcqDnAKFqnH4LqhhGq8rHdAIZqZ3ZwgOW53k8jdA0e3OhkAQinarA9?=
 =?us-ascii?Q?hwuNVxKaCKtw193Ts/Cty4QT93gXA5TluEb/CnGHiRGrurIvSfTbiPWWGeRo?=
 =?us-ascii?Q?a/bYfUzUdz/Wa74tRrL+nCsh/zPvDzMDN1Sc6p/gAw+GCxNTnSeaaBUkdOfh?=
 =?us-ascii?Q?9cdqyXFFChNDCDhJtK1oCts6BFnBXb7Ql4JuWYl9gKpmrY1eJmjjyMmeTnLc?=
 =?us-ascii?Q?MfvKpRmPom3qMBr4M1giyFwPzJ2SjlHgX0MOI5kDQLSHErMCz13ToT5J8FBH?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YpJuAqe4jFPmToHSJ6KgHuv4nh+q/UXqgACMKU5KhGu/6tCNh1wkfw08ZF4sWNy3JlHnuAVVNdtoy+4HAWJ4rwRQMgnL0GldKchI2dOLD2TC2h6xWDtx+tFgu+AvPB8ie903uD+IOn9ngGqeDGB91dSgj1qZjJkaX1/eCjLfUYCWpKSDpKTRBHTAgR4I/EjMg0mfgPvFhaMrCEBpHbVCUx+xt1bLBgxJVe5Q6/bZ7tX03YBYyneIj8MxO5tnvodU5FpXpuVYdG2X0rq3ZKncCQIuZleVc3+BofeG0pQwfbGJRYer1Tin4/tL52+lyqOwDiBAmwOdamnqwi/TqkiR+OJgEd0qV7UBC+2eK/PEv3LwRqa5fCU2RDNz2ky1+sR/omIhYLaOYfLaynyi5kGy0ugcSLbXK7oGw93mRKPPL0PPV01UL4X41KoRHr0q/P26YPXiYN15jVa1HPmm/QiQTgCvdQe0TiiyHBkrnMAH55EH2d5hGTC3Wnz3/ZgcPQeZmctnR8MjVjcKmip7uSkHhG8d6mU968U+9OCdZInp/++4gh8fhMQ+KJfNMgkVEjbzISyPG8J2LOLCseYw1rlpvUJNvela2R0aIuKslZ+iQ4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373bd1a1-0cf0-46b4-f999-08de1c1f5ee8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 03:56:59.6454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aX9h65dMviPLBRK38w10kWUMPe0xWNnpxMWe75SRxDMYVsV1U1Su0krMoTaHOTZQ3lNIUuz6UXpnxGC7jLN9hIjjbzAhW0P9qDr5LjRaoT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050024
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAyNCBTYWx0ZWRfX1QLz4dFaCEK3
 0xplUXtwuJhENHhU7NjToB+pDFPqDJvWy6khTE8LHoUXGl9x1zRmJWi4lSNGA4IaRpL2M2hiMoj
 vCw+8U6Cnm7AcbfPKSfewNC/yPEo8e3USIVLasV4VMatDMW+jKHRYW+4CDY2hI1UGl31MZyXgKv
 /xE5ovNflgQHysoTQwAdlc0X6Vl/XyeEcclL3D0M56RocWOr0ULaBdAzuNG9m9HSn0l/BR0OzvA
 iJCFrkVbberG0C0tP1xj4P/6qT6UtADokHrUDqC+STKCmMN5bH3OP5LvkoB6Xy5Dko0MBmLiEZM
 29LFuDIDUVgjv9Iab0laXP7FytZhk6+EX4FqWmHWuYKG5t7IBedkBotfItOfkDzc0aBscnuE/+m
 IPJDdMAh5idGboeT58/4vjzLZA5b+g==
X-Proofpoint-GUID: f_wVEBmpsa488GIhPih0rCgb8QEYkwGg
X-Proofpoint-ORIG-GUID: f_wVEBmpsa488GIhPih0rCgb8QEYkwGg
X-Authority-Analysis: v=2.4 cv=PMwCOPqC c=1 sm=1 tr=0 ts=690acb10 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3iS0BghZzbRNRFRvidYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22


Damien,

> This patch series implements a cached report zones using information
> from the block layer zone write plugs and a new zone condition
> tracking. This avoids having to execute slow report zones commands on
> the device when for instance mounting file systems, which can
> significantly speed things up, especially in setups with multiple SMR
> HDDs (e.g. a BTRFS RAID volume).

Looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

