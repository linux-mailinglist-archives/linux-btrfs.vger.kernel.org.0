Return-Path: <linux-btrfs+bounces-9758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF559D207A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 07:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228571F224C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7768F14B06A;
	Tue, 19 Nov 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Njbbstmb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EGbFpQTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02F513B7B3
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999400; cv=fail; b=aRya6I2fwVGf1hpwQGDkuj/LRfnRysPcO61AitXyNQKKwgiwwMpo6LDOMePL7gCdbO791RESDVe77FQfP65V7J5wXLBuen09Cj1A80guZd6kfeTxSLo3EMDGB0TfTCd1StYk1Oa3K2el2CKVnLvzRD3U02gxfLOOOKvXsxGYhHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999400; c=relaxed/simple;
	bh=CkmgMoKXSDrxX0mKJhnkJ5hb07pWBr0fX0AFcpMfm08=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DNqaeymUtqH0tffaTgVcceGTVZg04QQ9nR37iDlrRyKjzwJmEcEiVxOaQ/krTPGXuHZ+LkcMwQxjp8ltqoN6aWWCCxdWAsNNGVbWtKNA9tnBlNqpI4enF1S3Os5pgzdGdmV5zH3NzmafZb664ScwRfoziBENR5zBtX93t+UmOCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Njbbstmb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EGbFpQTu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6BiD0028002
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=hUafGZs0T8edf+OI
	HZihXjwVjz40LBk79qQmfZon2I8=; b=NjbbstmbzoSoQtzxjuwaSQOE4Xc1rhbb
	TDMSR24IDJxC4A1TbKKGroIbyAsZNt0FSLIWtcAT9ZHJPokVtAjs6Xv/CXeVGRCe
	DIzgEuIOpyvjx99m1TDTRVbCbC/YzSEn4cNZV74tkaW82rXOdlzXFZYWolc9oWbM
	kV+oxMIq3jREYviwJS3YmvvqL5kwjgSVcjgfms11EKY3TBMFY7t6FHJp5EaQcDrG
	Fnf80ZAQemvDzP54IQG+gwzgWO1wrcfTf4/+Rw3QvRlC35FJ95D4nUcAlGipZHCa
	qpImId8FLqjMj7blkx8C76nYbjioB5AcqJ4UaEBSaJ6Z5zGSJAqkfw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa4ayx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ5vDgC037967
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8awbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQj0AzbnFCc/MfQjUYJbhqiMeDTGXntXvwnjqnbEVE8BrN/e5wvuz+WwVc3zLkRSzVkY/xg9HMz6t/hGkaOUAWl5sTtG0Zr9gOv6+Ss3vI0W/8XlPA4/na35KVFDCD+rbH9jlEk6mHFm4gju3iBcxcuTQOI2mIdPXjERvMNj54oV27G2tFMS21UGqvbLHxAPiyZWCsACOtPwJXGCRLCjEvadpJNJyjBW5j+5JlYjuGI738GXS70E8OgOv342oM2UwywavhESvngUYqNJ1+eaG+aL/VmZs7JTbzLICO9Wan6EnL5CotrABsCTqVpYYwpn6kicB3Zqp0mF1jL3GGogkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUafGZs0T8edf+OIHZihXjwVjz40LBk79qQmfZon2I8=;
 b=fQhKfFpiAg//WyRm8doIzGeByZW3mjm/XBRsKlQkOK4q/VZPMpIIWuV0g7s24ztSu3psR1nhGw3QcTIwBiIRQH8Bk8+3Ja/5EvM8D03RpKhvX/5tRqlkY8B9pLBwcA702RhIQZtAW4cc0+fh+gQbOe/DHoKp2eiVvSTWO6S9swtmQmyNtwzY4aI5u9lsaWszjhVdgegc4G8yZSgyOIUed1r9Dbo/p2e55epFXq2N3C5kr6qo/oGMSNmhT/fi6c+E9C5KYRuLJMyZYzrh1Ov6qJVG8SmIAoYWK+YUz3VpGsMEyF3gwmUqWS7Z7kZPXRwgGvHRNihaCDmuzLmVC8qtQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUafGZs0T8edf+OIHZihXjwVjz40LBk79qQmfZon2I8=;
 b=EGbFpQTu5ytt2xZZ0lnJH48uJrnki8ETuD+1yfkmexcPG85TFnknFQSYYuEgTsiQnLh9ni3KbXvsXCTibDBAIHD5Ik9/rK+Lt+bNYrhT0msbYIdpQ5k8VWdiyka4KSAWh1/gS4Mtn/kr+INdljddPx20iB6WugM4VeRVfCSKMTc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:56:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:56:34 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs-progs: fix documentation build errors
Date: Tue, 19 Nov 2024 14:56:14 +0800
Message-ID: <cover.1731998908.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e6aa2c-aac5-4285-2665-08dd08674e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1H+QMfOfPhPzbNS7sIEBZCHSESMz70bJkgFa8JVLPf1iREdutaWRYYDygYIW?=
 =?us-ascii?Q?qnfGlR622CVoF4txlQ/Awk+QzIkEPOJsVEhcLMa6RM9RfEcLMLsrnQJ8suka?=
 =?us-ascii?Q?jIVqCo+9BIRiJHHzPOim9T+CBcbNXaV6DTqbBOhpNvWNclMutuPN3hjThwFi?=
 =?us-ascii?Q?Z3BwZQf6HZwzVjZnzgO6kvNHMVFituo4Yh+8TZXqaLfUlM03PWrcRDywX7tr?=
 =?us-ascii?Q?sjNNQyQ/Wtaeuu5Oo9YTPuhWFoK+MYvyQf52f/+j7sUo9baUefYHEicKU6HC?=
 =?us-ascii?Q?HqcB5uZSCwa+/jrdaWQNIbrnZ70h4+xzcTpFoa+8t8+qY5q+G0v/VIrIQqlz?=
 =?us-ascii?Q?mWdEJqOInJ1oDCeZIMdSVRm4pkpvBe4BXNbKeHP4TTE/D6Jt63hXAL2gH2vp?=
 =?us-ascii?Q?foWAqQqSVj+alNX03jH4ldvgmFuVVjmbcZF23zMhiRBnms7U5T0iPKGMoxt8?=
 =?us-ascii?Q?Bzz224X+gR76IvdavNCNN6x+BuJ2VuBSw0AdfxoOTui95niXn1vBWFnwbJcy?=
 =?us-ascii?Q?J5y2mrt76ShDGzfyVbKyy9vyaIJuRFyX/aqkfDnuqaDdvkQtOHwifyKnXaat?=
 =?us-ascii?Q?wPhU+g8geij1OBKUKaR9rQx9Tv7GjnIFfd5FJgZOboYU1kFKG6ip8pxx4Ysu?=
 =?us-ascii?Q?6/aAKQZUTMcx3x6iShedQFNnEb9kC0+09YSHQpS7LyRGsLJYLDOwBmMekBfi?=
 =?us-ascii?Q?ND/4+JCrGH8Dhh60ogqsmo8AWVrcW7ArNEqV0EBBRbLwhP5K1ZsPfQKtbatd?=
 =?us-ascii?Q?W0k57wmdWoJSLavp8Pe9I631SuMTieQ+n8eKOqsiwczqKx1ztfZ5bIfKu9uf?=
 =?us-ascii?Q?Qhnlh81H7ITQBnjZlxbYIlzd3tmlmhdobjqHZvtk2Exis5f5ohaXgZHn2e/+?=
 =?us-ascii?Q?8uiV+fleheNjikfSPgR57h/pRqbGQiUbTnwYWFuAHf9uyxy/amf5OEFfrS/O?=
 =?us-ascii?Q?N5xMipYHVUS/SDcL38StqIUgKgCpPvAFd95GgQvyagLp7CMXBP+0WW2avkRt?=
 =?us-ascii?Q?jupHMEvZLDbrbwwnAGrP6kCmKTj3SZ5qy74PtHf3W/K1AMhhci00TlopR+1U?=
 =?us-ascii?Q?zQCj2k5Aa7lP5NpdGuD9H7H07CANpj4UrYGJUQEH45LbPHp6m6W5BM3rEiNu?=
 =?us-ascii?Q?pzuRCpzuCcGP8eqgq0vQKE/4arbBeYX3DyOX4k7UifV60xpe2Dlypts7BECS?=
 =?us-ascii?Q?JKFKIO6+bepGqNF8QZd2UPs/ZkDeIkzIeKAg6EhLbbarE8eq/XUrKYtmp4up?=
 =?us-ascii?Q?7yYZAN7vFs86/DNQAu1ic5AA0CecksRmZuvtBE+FxzGQfhF/I7E+ia/Qfy1x?=
 =?us-ascii?Q?eGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xS/xpOkG5cdq9kXLulJtnsy/voxT+ftoXp56zHSUXjBNigniqCqvBqHgkrln?=
 =?us-ascii?Q?U9rCgmLOV7W5f0U/ezqzRVBvXmgJUeBZcKPCxBLAlQhKptFYXqW1Ts/EI4yi?=
 =?us-ascii?Q?h+VIHE52Zs1oDXRiDwlUsL9QxCIm6GfDgjLr2jvgfl7EAME2lzmleDaK+pu8?=
 =?us-ascii?Q?GTTGj0iUl0CthunGrBKmUAG8KjcnW47tcXu+iRtZkl4HpFoU5sAzfEaMCGq6?=
 =?us-ascii?Q?zjAfFQzZV56aRosZ7lRtSa7ZyI++sEUl3BqVvNZ+7qMXGM3el9UNGGehzDXm?=
 =?us-ascii?Q?ppJOULac0Qx5yggZoVbzgVkMBjFE02DQuzvCPR0PWSK6bi1nln3xVKGBSPUY?=
 =?us-ascii?Q?yTt0ZxeYMcuW0S286qiWiaZ7c/m2pEwjA8SDexUuf79WyK/0HTKwWnFUE2bE?=
 =?us-ascii?Q?+X8KDlqAbyuwM5IRLA8oFhZ3DWMCMh7sU7dyLvMOL5VXkKDEUT9sc26m0l50?=
 =?us-ascii?Q?+iezkdUP37Kjv+bFCzfrtEUaFh0bQoLm7vjhdVAubRjskFM8o9pgNEQ0xsWq?=
 =?us-ascii?Q?dgvim2HQ18CTasOeQKvjkvSdaZXsXpPj3qig11mtOszC2gKmMiUtiHbdsHnC?=
 =?us-ascii?Q?ocnNXjj90Q1WMsVpSL2IQQGkWGcnrlPJc3Dt/UltqGm3oWDMzeS8TGdl+EIQ?=
 =?us-ascii?Q?vhTXoakRGjAIA1z2P9A+gkdF4sAnh6Ov2dnrAvzZzchj5MMceEv+b/NPAlR2?=
 =?us-ascii?Q?bOnNT9y9kO8ivXtQCI3DlD84hOuBUmiPsh8wXuQeNJqpvw42VHhbevYZbbcl?=
 =?us-ascii?Q?cViyM1SvnIlh42CCoOS4IXCR6OeBxusBkSGbqlbtHeQjgBN62G3O9gfBTlqu?=
 =?us-ascii?Q?0pxBLpXnClATTMOH+/XPOt426DghdCLGRVw2YCyC5S/eYimA6U9iD7IQZ5Lh?=
 =?us-ascii?Q?H7n0ry7+Wb9ht1TbCBzMn+KTFPvD2Pk/WuB4SgPJIweZmatG6W7BlIuvHS18?=
 =?us-ascii?Q?t7upK13OIA8VdG6CeX+f+i9gRXLAVanJszE5dUht9exkBYBW04FqZL7YDuiC?=
 =?us-ascii?Q?mnuGhdsz+zj6BbfKkttsRymW4gVVFkRgEChjZqhKVXidD0/ndsW5wTt6Qd8L?=
 =?us-ascii?Q?AuSb8ggBlG+Pnf3u/qiy+YHTS55ozhm5gkxJ7nQs3IK7wPQLWh3jZRYhD5z6?=
 =?us-ascii?Q?oOFLltjZVpwiSJJepPljjgy51J8uthFLbwZtvhT4ZbnfVjAhAPoIVST9mC7b?=
 =?us-ascii?Q?eZQG9NGqnvCEOupPWq0G2Cw73b0iC3RhA8ZQziKGFGN/K9rYagJWzZp6qQnM?=
 =?us-ascii?Q?Sg5UiXAmbFXoUErh4dSiwP9jZIdbhZhcyOIi2bKFCAVs+zjf3CloMs7w8JLm?=
 =?us-ascii?Q?Ci55WW71yx9Fu7wdFMrfYF8LUV1LVftxdP4BmHqtDqZGeRBddgwGDePndtt0?=
 =?us-ascii?Q?SPHqLKxNfGs1ocaS/6f/vJKEIMe1Una0C/PRTAwC9EjltdcBcNFxjK6ztqZj?=
 =?us-ascii?Q?zhpETEDwF9SzwTXqd95AGFTw/tk7hc+Lsj2i2fzEGohz8SFBaPa9aX6dQChA?=
 =?us-ascii?Q?LTNVocYgtD/OBm3J+4f7STvg68dDkVgSRH9FfFsXuprXZI+kBhbvJUyh9dzT?=
 =?us-ascii?Q?272ETp6QpzQypyYV2k4WRGzl/iEOlXyyCMa2fbFd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tU2jaIiKAT5eOGeNRhKRXrmLEnvrA1Q0xYLZeeCLCzWeCcFBg5ZUfPCQSVhgIX9eoXYe3INyHdvdkTv2Pksiykr3GU4Av/qL3130LY/ei8xgZmk2I4JGmjDx7/rgqfmZzoXIJ5erkkzBOzLyQjFIZ3OudRZk4zgRqJMaXZAG4sKVJkYyCeCv4x7d9XxSzKXFQI/4BmcUHdijRnVLH3v4x570iCmIdML6EUUBANKo72KvnGa8EVqIU09cgo61b/tTF+pv4hl1mpA6yJpHJbNj67ISdEYVwMPuq9vafw5ImlND/7D3VJctKiFzie7QTffoGuCa1UZOUHe6+vN+wPVcLX36zuHuR7mta7O16ASr8Re17TUw4JLbZAHDmpNrAmyrS+GsAqlNgkQq8exErzJ/XP4YZpNVHpYUtrPlTMT5Lha+m7HncIPJjxUllGzemVg3G9qeXGcyi02ELFx/+qx9kKd4wN1N3XKIQTu/ieyvLpWIVjCk72BoO1P+rkCLbSFCwuf6mQ8ghCjJW1vce93SgGLlnPzUkoVKDKTTOfcqPdzn74yNnCKFDWmKNx8SMj8gijQwCYI29F8JrOLE8ZZxc+uz5S9n8rfy9VnSlubVmX0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e6aa2c-aac5-4285-2665-08dd08674e2a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:56:34.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vmbrUSVgYVMPT7JPDyGFVtDObkF83Bsbrm/Y0RjP9PxG1Nu0lkB3LYr7W7gs/DwTKpp1TnyQn3DxIAZ9F4BIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190051
X-Proofpoint-ORIG-GUID: Kxc-3_yuB_2fPYQ8yPjE1uFUY0weiJyb
X-Proofpoint-GUID: Kxc-3_yuB_2fPYQ8yPjE1uFUY0weiJyb

This patchset addresses documentation build issues related to
link formatting, indentation, and target name handling.

Anand Jain (3):
  btrfs-progs: fix doc compile error in CHANGES file
  btrfs-progs: fix doc build issue caused by confusion between BTRFS_
    and target
  btrfs-progs: fix doc build errors correct hyperlink formatting

 CHANGES                              | 22 +++----
 Documentation/Kernel-by-version.rst  | 88 ++++++++++++++--------------
 Documentation/dev/On-disk-format.rst |  2 +-
 3 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.47.0


