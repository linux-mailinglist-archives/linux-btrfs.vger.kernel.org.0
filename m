Return-Path: <linux-btrfs+bounces-12643-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE3A74311
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 05:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D01179829
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Mar 2025 04:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC718E377;
	Fri, 28 Mar 2025 04:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWQxD5gV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dzlcP4Hv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A58126BFA;
	Fri, 28 Mar 2025 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743137518; cv=fail; b=CUKN/tPz9xt5H/B+VE87EWEi1E3ZDl6kW79hQCWzxoG4oJGoOO8ouBdRrukItdQcPPmCPDYKTDqjDRvSh/DOR8IQVSdW1H6qBtPkUUrJ9tpDHJRNpNYRkLMpJRv/Nh/b8+Gwh3mP4n14sp3j2/FSpTCkMgnK/gt6i27Msg43SeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743137518; c=relaxed/simple;
	bh=YcaBw3DC+Pu9Rdzb8Y7sH8Qsbx/Nz+xrljhJ33j0fzY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=g0t4FjxzaFL+WiK6IeD98mzi5Tg1Ztu8Lprje6GPpv6RnAC4t0Cjtz/LL9XodkJqQkOjN7WKZef+UQsA3p61E4V7jP9oFTmCAR61CSj/nG1WYXeNvm9aeStJjm9ecHXzY3cazltRwfQ0/grt88JYBIDaHwjo/kx3TOVOdWI6U8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWQxD5gV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dzlcP4Hv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52S0u3vP009432;
	Fri, 28 Mar 2025 04:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=kbXgl3CgUfef3kfs
	ZjZqbXBHfXeJf2BqFwgMqzC/gd0=; b=KWQxD5gVncJZTMPISY7l6u+sNyW8ZGUy
	0TCRGQKcNhSIdJEjdtTnc+d/hJRo4YFIkkmBSxmvIFT3uy8kAoEAiuA17Q32skVH
	MKJfeRMvX2Wh5pXda6uRj6qPlk5RnKiKiPD63USVOyZvL0+nEmHMg0EjjnRmZaWk
	IUFmB47gkPnOBKyMN+Q1f9NKscEps+/N4XIvxdef0kUzfPGuwHHy0ZCCRXPw/ii2
	t60An6smPveCc6whrji4TLIuY8xR0p75OR6sBA5rfMv2aVJY0LynF8vPKUvJkQ+y
	za6MUIFhKr8BYn75nPcTCDWhDDhMYwMaqCCnVebQ8C2WUCPouSbyeQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrx3e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 04:51:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52S2qT9H008201;
	Fri, 28 Mar 2025 04:51:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6xyaj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 04:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2D6u5K98zcH8/8t7rxi9v3UTKFqhm0LwuIVQr1gEFgN5l36nMkY/4PLD859MzlzehJIRot+HaIUORm8BcMbPC0QamPtfckeXGPTXQhqdHbXorfrziXGxw5H9jcwq67NxRe4Bpbgj/LhS0ctGlbqV9MlCoc55o0+qts90D0xE7W1LJP+chzHB8n2FUb7RinjJQ+FNvOUvJsEHiq/X6a2blJuCD1dy6UBCY9LXk5ndUsEx/VVZ3s9Typ+SL0mnJvFQ3pSNKued/QGaKx5d5mF1vvsUkvJeUTPFESk1PIKRB9EGSpL8AFVUZSbz7Vb03d4teMcuLJ/pxIAZp39PbtcfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbXgl3CgUfef3kfsZjZqbXBHfXeJf2BqFwgMqzC/gd0=;
 b=rNrTEeAoi7Ucf0860U9+0epa2Ydxjy+7gwTSa9fWfvrtLarG+Zu4PvT6/GJatnMePHZ08ZDSwmwn82M0But8QJJxxqgAhlkFPj2RenSwmHsuZ+Ml4qQBQwZwh9Xi8ncHc9dnBNauwRlQC+q8vdBhdOuOehJOMnOyFbQgV8ZWhd3NCE6ZW8Rf2t51uDTrZDEGAU//8X2jgF8AEtMD1llau1oFmgXqcC9V2CfhS0pD098OCB1zcfw8VBB4QfTXBe3Vfz+gYbVrey9TVfci8q+pL9R/eHHGkN2s5bzhyXY2dIJPDW48Y1/CMcyZ+iuZcOnGbBdUldLpoaoeOKd+NK23mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbXgl3CgUfef3kfsZjZqbXBHfXeJf2BqFwgMqzC/gd0=;
 b=dzlcP4HvYhyRDUuoTwQ0sF9ExwYyXOeTulrEJvE9lw0TfagwjbzACTxtdWsL7ym1JV/ZDa4E5a03Qzk87CKuZMJpeyoB+jw+5xN76zfSoaZS2+GEEXEk6jDSlBg4HgAL7uPmFzcyRQOyu0Jbt2rI/Dqz74qWeCOcmE3C2XwNU4c=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:51:53 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 04:51:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] fstests: add btrfs standard configuration
Date: Fri, 28 Mar 2025 12:51:10 +0800
Message-ID: <cfb8c19533ac3c764edc1fe62b7fde75e76579a4.1743137470.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:4:7c::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 0387b0d4-311d-4604-ee86-08dd6db4421f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w7dTbi4EL1RgSU7CcWwzfDCGHkO44XiaqLzzZiWj1PSwK5Ix5yQkVCYqBxzs?=
 =?us-ascii?Q?qRwn8tFd+U1dPSbcCWmFXYjZi706BvPxj4n4p3h/ziskHSCqDdJiRRr+LETy?=
 =?us-ascii?Q?ZQzm90NFbFBehSHhJlWelhzPZkuy97Q8aqoLNAE5fjIESnY2PSQw+8RpWtdb?=
 =?us-ascii?Q?w+YSKIrpvxVR7fqZ3B49z047hTDDKHYMDCp6LWKbSIqH+m6gcm7Vph0I0tUA?=
 =?us-ascii?Q?4l/zLCUY0JzLALPG9zuLrtyUfHzADxfTWrG76ggtJXRXcn9L4s5KwEXyzFo9?=
 =?us-ascii?Q?ilRc54aRFtrsr4jtpm4HectgNUySKvTkxtcJLZwRX6klKLkFS+zui13dJfZs?=
 =?us-ascii?Q?DtgZQxm92bzct5+Fx80ZN0TjGB5cNVvSXgqUBCL9pc1EZDTf2lPTSN9jTZ8T?=
 =?us-ascii?Q?uv/Jr03WKy8WKp7a+eOj0BH56JUq4Z3X2huP/HRCIQ/RiPCE2O5RLYl1yg+x?=
 =?us-ascii?Q?n+8387rSpRx9wK+zeaoeCGFEXuFb7IxvYpfZYixN1MsWRRuCrN73mgk4ksIo?=
 =?us-ascii?Q?foVHBOmlHMvMkRf7IZoKn8yG+VcQpdtPAKdFT2Y8zubu0oLei8xHdthizu/L?=
 =?us-ascii?Q?TfLWvkseI99UrPNX9TeUU//dVyPbeHtuDa2umzHuCHCmP06hFUoOJe6x/SvG?=
 =?us-ascii?Q?989cu19ZjbYDiPvw3j5lbHLZ9g9tnTLASjV5JRHMPbmQGFm6HjPUpZTiRm82?=
 =?us-ascii?Q?xI4V1cJ+tw7QKXGAaIvaF3ktwjg632S7L0T7FJE3g8/PW+0eMavLOE41ESZc?=
 =?us-ascii?Q?zHIyuhLbnGbz3c+1WJLN/GLh9/PeBe3fZIX68wB5v0DcM0ZsYVdtORG3+4z7?=
 =?us-ascii?Q?vhUvDD2ZZ6l0TBDxvh7v9DnJ9E4rlkl+kyvV0vTpNGM+PQk33lQcxUxsI2fp?=
 =?us-ascii?Q?JdzvdV2Pj15l9o8Zb5h++UIoOSBg+5l5lbhzsWV4mfkskpiEhDhIU/CzHW+7?=
 =?us-ascii?Q?Pven+y0aGS6UBGgJ6+Gtx8W7B/+PybBlaRsgV42NHwPV0/tIXobRsZ67Oewp?=
 =?us-ascii?Q?Cu3B4v/S5ObbklZrXjkdi33k778zPLvmMTZPrewVff0Q/V+tPqiTrWxoObpL?=
 =?us-ascii?Q?iQO28yAQ96Duk8XbgX47Nr/DUz+GHIFUyiWitYw5xI3Ddq6d2zbfumiR0ElB?=
 =?us-ascii?Q?AU7u18vrOW8YA485DVN0eGMvdHZUY0alTboye1yGb3mCPZ+K7be3KZD7+cLT?=
 =?us-ascii?Q?I4YbNxvt1+UAbX4Wj6wQT9xoY8QiDN1CJ0hm5bI3xriKe+MlaoAJUPLsgAnO?=
 =?us-ascii?Q?GEHpX+jUWjA9LD1FJq8xtaYccuqu3EIYNBGpo/7PKOGgsOoLADy4qrWV+rGz?=
 =?us-ascii?Q?LbRqX4R/qBBJdL9ajNPsyIHgRwmcAZ8FK1zcMJoaPZYSLhGgAkxJ8ELFqunS?=
 =?us-ascii?Q?coMVvEaUgKYQ9d0aXg/xUvSUKDYo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JsM5eOW3+sIQ29abjBZVozAs1lVVX0yumB/s4C/K8X3hgQ5QvF5LSoYMeZ5C?=
 =?us-ascii?Q?rGpVDqD2hMEmkEA+/wzWU6BqK/BsuJjw4qvYEyz5Q1zOv/UAv2weUChMB2Xu?=
 =?us-ascii?Q?tVraFAwx05/0L6//VrT54ljtAZTJdSTCMWxBXB8Ywg50Zzk4gUfEBw8qcAD3?=
 =?us-ascii?Q?kLK/8qpwqdwxnR4485FotsDrK24tWhVpRguLYUTT1m5kdbYlREZCWxfTApP3?=
 =?us-ascii?Q?bHe0rt2XRDa4zgNDzK2AtmpN+lXbsNDfQyrah1OMfRXNLs55pkcsxGoGtDhT?=
 =?us-ascii?Q?Gt40VoJ8Ux2+T6ite6ji+xDE6ahIdc+7+yIn4UKxIs/P9HKwDZDsZ1Z9xzf0?=
 =?us-ascii?Q?SPM9xVC8E/cb9ob1frBoTQs2xhrmHoxCgQWxxHfC47SDB0GyEQRg/2PWTetp?=
 =?us-ascii?Q?UzG5ZMgND5XFHsQ89QfNc7BCU01jmNOlGEHYCAvTVeMfTxmGm9Ca4uVFWIbT?=
 =?us-ascii?Q?2I1K/JZcrAspHI+HPdasKpdYOUgWnQtQ3iyEkWo7W/qx45GiVi5ucv+mE6NQ?=
 =?us-ascii?Q?/6VTxYYbsP6hkZgV6pdWvZ/Zv7ILRob2+sxxerGF0EAakiX21l9M4U6nvDSS?=
 =?us-ascii?Q?MXMQyVwT6aauwfDX+cyaR+jo2VHWg/Lur1OmyqWRuSVGJwRsh1jN4NjBhnQ/?=
 =?us-ascii?Q?RfodqQcU+R5XvBb/a8I15pK7CdGGWVxqfA6zQAyNxSmlD8TyMgVlbeQK4nlS?=
 =?us-ascii?Q?vExbgvgDLRSsqC/fgm7bS3tZipKs+s2CyDjCa49nNLxkXfrR8fpC68eyv8SF?=
 =?us-ascii?Q?SeFq44abOudJr6BjpXfEsjmvPsdP7dzxCp8LBeW7J0+/cPsjZ8H+9of3+J/E?=
 =?us-ascii?Q?G/vINTCgQ/trJaO/OLfrZovnhAW95JYnx0tmOmW6z+kJWaCDOKTyu06oK3Ix?=
 =?us-ascii?Q?MZAoi/6mzwkUbSehveULcSNE/vrvh6Uox38j2eGHphC7dCY0tjIXDMicJzPN?=
 =?us-ascii?Q?GAkNHxD5ZQUiQEuwDr6C/pAQufOiy08kUK6CsD9LSfyZvDIZEPdQx0ATFQDr?=
 =?us-ascii?Q?VO88FAQFiHJLto8+0vIoh2lAZMVLJQSJgB/doDEjGjfvRuoA80TGF4hHJeI2?=
 =?us-ascii?Q?Aaxh2SscFGrGM/6uElG9GvEr13c6v+Jf59Df3Ez3PF/puB3Kw/kgUMIRRMF1?=
 =?us-ascii?Q?QGHMVTw4FM08N/gXz/6K8w5CdGOigrJjytAJIu9l/NUKTrdN7KGkT/VNAf19?=
 =?us-ascii?Q?FIThsCxfkSsZXLlLE2eO9fiLFWk2BB9L7oler11Wi+O5YmznCDcylZEmlDJv?=
 =?us-ascii?Q?LfUy2f4suSB1hUp8WKqE1UIW8KnaHwSf6WorLfOJhT9a3NUcFIJX1bwUuGN5?=
 =?us-ascii?Q?vHNVtOuYOpEgEZac9abuQruZFBYQ9yjWKBwBnNX2G3AEGs/ZRi1fjsc1FEDb?=
 =?us-ascii?Q?dfm/LDx/TeEjFFgbSjEMt1X0UBIcfR3KJuV+XYW90+9nSo9a0VbnWpY1sZvI?=
 =?us-ascii?Q?G3e0C2OYujeWn3cY68fHPJ2ncgmgpRoStOrTtGinYcWJSZ1XmkSZvLpNwBq4?=
 =?us-ascii?Q?+HOfBEfcGBXSr64sOvBNzIQOXDPIrVzENWrHNyGpbLEpcpSC4V6NZ5mt09Wz?=
 =?us-ascii?Q?c1bqMu/oPhvB5Ib/LeQoURatjF6lHqqxFgihlDqj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xEvxF6XR8TBFW06uOwEMD7hq6TMMrqSLp7sKlkyKUeNtX87HsAcAToILAabNX80DxLnsMsHvowniAVf2IkXuct5xmhe31eJhjKlkqttmMOo6s5LraQZtjNzCsaG3cW9143uflZsCdbneaSl1taqtnzI3XwLwYjLRyGaSggp4CknICE79sQ7+FWcn2fNTAUyvH9wbCbwt/A8joFS4J2gfQUnmGZ/DGasnBF208//PTAT2gsHw/GYtGWN/nIIC72xzjDFiWk8OKyJMIIX9Vvqyy0MoOcHC782a7hyZCbQGplhuAfaV6TkFBpIcQgsrE1tzuwJoooDs0MYO8CTaKv0058UFRWkV0mjQ5qT1ypv6429BhFN7zckfRKZktseZ4wOBvcF/PLPz7ST0C4wqhgwxQl1sK7YJEuEJg0KFpn5c0b2NPQRLwu2Cj1QSNpHozvpOaWQQoIMZLLALMvQHFbZXdbr+j7BvbL43pZH9oxaYs5MkOWbAzL0aLD9M6N/ZwEGRjfBC8GyFQXe+v3/cJi0aPzUh6uzlcqqAFDUKqNzb9s/acGRjftvhpHx7Zh306IbLNhM/HMlHuJ+3BGvvHzBHriVAhdNaMmUkPOkb390IwwM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0387b0d4-311d-4604-ee86-08dd6db4421f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 04:51:53.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5Cpv4r64fbmRNiMtu4YdGsMX1++RDCOG6I4MVyqeI0KaxpBvwe9V2FYawOjPFkXm0opg7AU3U5IbC0CtEltXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280031
X-Proofpoint-GUID: t47JVxXOJuJJrqD9O1KNK2dTkKz-wwVu
X-Proofpoint-ORIG-GUID: t47JVxXOJuJJrqD9O1KNK2dTkKz-wwVu

Here's a standard configuration for quick, regular checks, commonly used
during development to verify Btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
- Renamed config file to `configs/btrfs-devel.config`
- global section renamed to `generic-config`
- Section names now use hyphens
- Added `RECREATE_TEST_DEV=true`
- Removed `MKFS_OPTIONS="--nodiscard"` from `generic-config`

 .gitignore                 |  2 ++
 configs/btrfs-devel.config | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 configs/btrfs-devel.config

diff --git a/.gitignore b/.gitignore
index 4fd817243dca..9a9351644278 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,8 @@ tags
 
 # custom config files
 /configs/*.config
+# Do not ignore the btrfs devel config for testing
+!/configs/btrfs-devel.config
 
 # ltp/ binaries
 /ltp/aio-stress
diff --git a/configs/btrfs-devel.config b/configs/btrfs-devel.config
new file mode 100644
index 000000000000..3a07b731abd9
--- /dev/null
+++ b/configs/btrfs-devel.config
@@ -0,0 +1,40 @@
+# Modify as required
+[generic-config]
+TEST_DIR=/mnt/test
+TEST_DEV=/dev/sda
+SCRATCH_MNT=/mnt/scratch
+SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde"
+LOGWRITES_DEV=/dev/sdf
+RECREATE_TEST_DEV=true
+
+[btrfs-compress]
+MKFS_OPTIONS="--nodiscard"
+MOUNT_OPTIONS="-o compress"
+
+[btrfs-holes-spacecache]
+MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-holes-spacecache-compress]
+MKFS_OPTIONS="--nodiscard -O ^no-holes,^free-space-tree"
+MOUNT_OPTIONS="-o compress"
+
+[btrfs-block-group-tree]
+MKFS_OPTIONS="--nodiscard -O block-group-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-raid-stripe-tree]
+MKFS_OPTIONS="--nodiscard -O raid-stripe-tree"
+MOUNT_OPTIONS=" "
+
+[btrfs-squota]
+MKFS_OPTIONS="--nodiscard -O squota"
+MOUNT_OPTIONS=" "
+
+[btrfs-subpage-normal]
+MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS=" "
+
+[btrfs-subpage-compress]
+MKFS_OPTIONS="--nodiscard --nodesize 4k --sectorsize 4k"
+MOUNT_OPTIONS="-o compress"
-- 
2.47.0


