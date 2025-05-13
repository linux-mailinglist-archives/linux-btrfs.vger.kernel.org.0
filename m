Return-Path: <linux-btrfs+bounces-13954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F59AB4997
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 04:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFA71B406BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DC1DB363;
	Tue, 13 May 2025 02:42:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F33FBA7;
	Tue, 13 May 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104145; cv=fail; b=WD5LBF7UXpeC4L7vfZnJb09sk+X1bN5vcLEZOqBhACeupT22N8L/z7+EchL/OAexEndCh3Zz2dzWiNpE4XqExqfDaHu8FpbVjZd3LmJUMVSDmiPcM5SQ+KFCZwumkeCXyezIrrweceB04Nl0nPGmAkrE/a4cs3I23g1IXDPW/sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104145; c=relaxed/simple;
	bh=5KK9Y3tbr+8UybV93EY3pkF5455pMhx5rwYGQk8XD/o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u6sIVsAohP2ZhI6M3lLeipEGXpHcoqS+bXsH7NlW9GzhBSDxcQu/ZYqGe2WzEkdaJUgLBe8BCe7kOC7kBGflyP7mwBcT7sHcu5SgZKFjOqHBnz+vp4L0EgAU3hEvPedAjbe1x81yB1fuTE85F5nDtl23S7Sl4Ph/+qppdGFe1ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D2cJVn031209;
	Tue, 13 May 2025 02:42:15 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46hv11jhbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 02:42:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZD+qqcr2LSvzObp/rho6+P9cytLnN7iCSDFEIzWd6aeaylS9We4W6F+fuN8aKaKQ4Vt/xHRD19ezSYlNTa82ISqmpQqr2HMHFaoN2xuw9IiHC9h/XnBsCOXXzZfUZ/yZwC/I4rqM4m+EPm5+oDMw+PVsgbyMvJ8di28qSengVYWRcNCyn4NQxVPmRJXETfqoLv8ZFqFp+a5+QHzQ2WlxzaHftDXgGuOBnYa6l81zCM2IdFk3OOMIBIHCgyzyP5STe2H496iH4pCu0MQE9b3K6X1/SRKXtw63tfPLg3SCn5DNW8G/W6l79T39xTSoI7y1vQhe54J4rgcahHzQsDN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fG7pr3C71nKisG5Ya1VX2Td+zxixH3tWTj5WYF1K4V8=;
 b=LPKcs0eVBbbtPg6BnPKtA+v/TXK9E1yaTsbBuGs8VCYwnR+zLufNFofHA+i0WaZuZKS30Vk8IhUCohRniAm8EcAAmS0tgqS31RONlkj1f5mtnahWpkWU1N2WJRGB3Qwe/YzdQ89srSa0aaiOhrDKMVKKg2d7O3DzxzMWGvgVvl9wdXs8hsP5U331Vg0pLGLOpZAY80zuDLc6f7KVrKKFnv0EI/EVCy8W04qKJJix9w6p0f3buSiR4/lXyuJSdMuGwTw7On4RlQXy+YEWDMQCLHapD1oWdYgLtnkWirRSpuDrMw+/LQzLxqoL52xr3HB2sEpJt4cgzDCqVHC4wb+PDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from BYAPR11MB3832.namprd11.prod.outlook.com (2603:10b6:a03:ff::18)
 by SN7PR11MB6851.namprd11.prod.outlook.com (2603:10b6:806:2a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 02:42:11 +0000
Received: from BYAPR11MB3832.namprd11.prod.outlook.com
 ([fe80::83ab:15a8:cce6:b531]) by BYAPR11MB3832.namprd11.prod.outlook.com
 ([fe80::83ab:15a8:cce6:b531%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:42:11 +0000
From: Zhi Yang <Zhi.Yang@eng.windriver.com>
To: stable@vger.kernel.org, fdmanana@suse.com
Cc: xiangyu.chen@windriver.com, zhe.he@windriver.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, osandov@fb.com
Subject: [PATCH 5.10.y] btrfs: get rid of warning on transaction commit when using flushoncommit
Date: Tue, 13 May 2025 10:42:00 +0800
Message-Id: <20250513024200.1811319-1-Zhi.Yang@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To BYAPR11MB3832.namprd11.prod.outlook.com
 (2603:10b6:a03:ff::18)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3832:EE_|SN7PR11MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: cad35da1-dfac-49cf-af63-08dd91c7c312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W9O+AjfLlPgvoPyaD2TAGaeml9ZkIrrXRkFGNr32onAkEXLosxlpZm2Y3M6b?=
 =?us-ascii?Q?ilatj9p0VRZrkvjD5ILhZumexDtj1NunzkCoKy21Dp9utbFdr+Rfzfr709bv?=
 =?us-ascii?Q?4i5cUPmzAdWwzizHVPLWpYVXuSuvCFb4F1svRN6lVrDg71J3VeQuDhudxF9E?=
 =?us-ascii?Q?Zw3gHT/jOvdAyZnmjn5Rjgxolt+ixRPubctWTXW72IQHVjgJsVSmUX52FKKv?=
 =?us-ascii?Q?u1t+P0zXtTPoewbY8KzDhZdCg6IXCKSeAVzfdrUQOhG3HpWV5rtKYcOsOmWh?=
 =?us-ascii?Q?8Ca4u42w45FgG/sPdmTUmfTh4y+UQp1SCyCF27WmUq/T/AQAqrESzbIUccsE?=
 =?us-ascii?Q?P0+9FLw6IuTkGcFvilq8IOgSN9TiyuL9QjqOsXxzX+rIeQV/e73t89DacaQh?=
 =?us-ascii?Q?FzSOnSxohTlN6evnV1/oqm3xA0AfLb+k3R14fORRZ6G0jUds0u3gmhHLbBEz?=
 =?us-ascii?Q?17fdkU8oiF/ISdE+2tdQch8EgWzP+RLDQa96eQiePHUAK11jlLnFDmp38YWi?=
 =?us-ascii?Q?z21exmUaF7TE61RLxDNmAMaq1obYm/lKbVS4aqdhvh5NnPhv1Xwlki7e3vjr?=
 =?us-ascii?Q?yw0MjBjVZU3WK7YLeGxUz6zkt9+ka8L9dFnl9WlqPS+vmg9Qc1JzFm/8KcEt?=
 =?us-ascii?Q?6XjyzjnYiO6HnDrAs2ZG/MFBzesGhM4ynhP8XDDxvQvmNUe95j8nbR8RvWFM?=
 =?us-ascii?Q?RtTGhwUetYwZ4j58CWBv7tffugUZTG8Uo8U/9FG3gm1tzTJydUF5ZAQVSyha?=
 =?us-ascii?Q?lpGzjycLCC/4C9nX3Dp7TCkJUsbjq42cIyfyJy3U41k3QNA4SrjHi5bMKlBR?=
 =?us-ascii?Q?GLeSOAAIc5NttUjvNUWEl4w6AbombDPJ0BXZK5OKb4A5V7vk+Q1rTjTtHk8N?=
 =?us-ascii?Q?dV3AVyJ3Wa5np9XR6ob3B5JDKYWtky4ZO01qeTjGA2KBGLs/jeyKYYyC7JmT?=
 =?us-ascii?Q?o48xN5ICZvmHzZd6UM6tZr8A5OqnXYZOHYQUi4B85VNPq3L0ZSgp4Xr/ZEV6?=
 =?us-ascii?Q?9DUzdr/VT/Nau+j/TnB94JU56LupgwwLqYL4uf9BMwwL5TN1MMRwhyZK3HeT?=
 =?us-ascii?Q?BUo+6WBnSTMkzFJesnXZkcnyY4+naK8Nf1kMwg+4dlz+eAjkLbZbHQRJfeMp?=
 =?us-ascii?Q?/iikUEXwna9taeMv0hUfgmMy09+e+a57aD+jDuuCN6Gux8SO6NjKDM0Jg8g7?=
 =?us-ascii?Q?nXOCSC+jHQA40XM97JQUxykDB3b8Tx8CbQ5pe97MweAavoDFrkZXWqJkU6Ip?=
 =?us-ascii?Q?iErMmXuJ+0W+bwJoND7iWpVG2jd7o4adonxwI3uY4U3hK1WI4WFkIkR9VL9Z?=
 =?us-ascii?Q?FXItKUDbBpl9Iyvc7js2RA2k/1jQVsPc34I9ERWk8KuN4wWD+FUvZmNAtMQT?=
 =?us-ascii?Q?8DvXPrLt9Qod2mm7EHTMq8Vl3GoJcz8qiowgM19vJT+MXPZuLD6PyFj9gLhY?=
 =?us-ascii?Q?nt5qctM4XJalx/3NxsdC95Jcct94Tf83hfIpkMeUvzHmuqYK1ruhPIwE32f2?=
 =?us-ascii?Q?nFG0YSDdNGo87Qw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GDHpj+qtMYZOaEYmSL97RgDXKd7t1V4EzbtCXclUDgqp0+NIBW0BzK3OXAjb?=
 =?us-ascii?Q?ugAqLFVoG/nvb2gWeqrcwh0PXpo4aYFeJDuvCtg0sX1lIuum0zL89xFK6XIB?=
 =?us-ascii?Q?U78ry6DnXc0Y71BGtZthH/Rvnig5N41YKpp9QgpG9Trf9jErjD+xBQzR3doD?=
 =?us-ascii?Q?Bu+TS31pEXJBg9EXDvgrEC3wgde2xMHzq1BANqNwU1whuhRsFY5AJDxhn7OP?=
 =?us-ascii?Q?mAuPUmCInDrRMPU03damcpW5xdAYpBun/QrZMvBsN7g+Zjja395rlD0Cj1Hb?=
 =?us-ascii?Q?lvVAs+74NFlxjvN4mkFYs4t+l40j4WMMWhMR/ep12LSPRinP8wLkAjiZTva8?=
 =?us-ascii?Q?7fpTHBppu8DcohPR0xyyvwn+Qxu8XWUK9gtVP9l/dLiynbqjWmtQx71w64KD?=
 =?us-ascii?Q?oSD2yyUKQx/J7x3IK14REFuIv2swb2Dr4SonOeCp6VBH/JpjbRA2UvmJUkmA?=
 =?us-ascii?Q?9aY41kPEPZQpTeNucYJfKtiyseJkx8TMk5P6WcZtFcVPLR5edmF82g1o94Ax?=
 =?us-ascii?Q?NCfg77ktGrA/QUjwHZkCWbeRg3iIz98GwP5RoWrspEFpFCi1aJrORYgML0h3?=
 =?us-ascii?Q?7GvugFjzUJLcltf95z19/yxCNi9jnUISoS5x+E/n/5GkoonDLWuqbvjkW19d?=
 =?us-ascii?Q?+zVGKFK7IhFz/anoLqTErf4m6Zwk4sk2IVzQD/4BGmoSZTT7k2ntqUD5esNz?=
 =?us-ascii?Q?3qA+Kv9L/vPUxtarEZ0Xnp50tGKhe6I5SUuK84DkYtcnQq+dt5l94A+EJXxo?=
 =?us-ascii?Q?iuGW84PXGhWqJcF3bf0N31Qr4yNichWrdJnepIZOEBChcvQvGeo6623lanLG?=
 =?us-ascii?Q?wIYVdKpjLIsobPvvXOUeaz/faOtQ0Z6C6WLWwOZfS7V69UbNyARZgviQRP4N?=
 =?us-ascii?Q?FZydy7pmtIziZBQ8wA4pSGm5C2PlD+bn4ngBF2kpnWk/ustwXs/7H7SE0ENX?=
 =?us-ascii?Q?9elOYVCybajGFjEsxI9SmBFIcId0THbBkLHpaWDFkCzgd/kNHOAGU60FthWu?=
 =?us-ascii?Q?S/B8YDx3KJXMMMf5aBc4orjMdS1+Ka/yz6hguCnjUpTF0pNRW3PYjGd2FdUU?=
 =?us-ascii?Q?ueeR7LjPPAdse0nCxkKPeR+J7upVhq/gWxaw6mLA4fbu27lDozqXSJAtC5U/?=
 =?us-ascii?Q?LleZRGEzhFdKTCKpg6gHzomBrcoIKGwlcNZu9JXsyMTvmEzwzyQXnDFRgDo7?=
 =?us-ascii?Q?nv9UI+IG8mKFow2T2Q3KJERgmauh/LJ8KlpJkTGNf1HHAghNE1pdySJCjz87?=
 =?us-ascii?Q?7mv2DYGXoP06s/fdkMx7bCDGbyuohgqpzo0KAhac4xf9SBD5LsVPW+MzKoxm?=
 =?us-ascii?Q?NaQ8422+IkHJL+mR2Y7b/O2m8XmDVtdVzeQaVGoS8z0bY1asVYz1KYWhWaPk?=
 =?us-ascii?Q?BOiCt3xJFbRPnXfECzJcAMOefFzwRC82CTaFK46bnuAgEd3jrYVLnh3aMzls?=
 =?us-ascii?Q?xGQullaHpjN1zSFu1jO5GHUqeCJfJZzNKKCD66byafj6a0USa1/8atEp7GOd?=
 =?us-ascii?Q?P1Fd4Xg+SWTc7i7EbE1bW7RnzgZMfPhCD6/spoV7qMawWWKFZvPNemL2+vq3?=
 =?us-ascii?Q?zDYPZESlbon1sfI7YWoF04got6n8fR7QiCybd0na?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad35da1-dfac-49cf-af63-08dd91c7c312
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 02:42:11.5953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKAprxe7gw5zttt6yt3XqOWPEqVlQ3/LIobjdNUgrj4LiXEZgGpVcak4pAnvoGr+gPobS5y2WTbo7bbh9k3aBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6851
X-Authority-Analysis: v=2.4 cv=TZCWtQQh c=1 sm=1 tr=0 ts=6822b187 cx=c_pps a=vIBLTX18KUGM0ea88UIWow==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=eo2_2SxpAAAA:8 a=pGLkceISAAAA:8 a=kT-NTsFwAAAA:8 a=iox4zFpeAAAA:8 a=ID6ng7r3AAAA:8 a=FOH2dFAWAAAA:8 a=t7CeM3EgAAAA:8 a=zz2pMRJkNtraGrOje80A:9 a=2HcKt27O_hlLFDS-qdQF:22 a=TLwuWKmryFjkTYsgBL5T:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: BU50fZgp4H-Utp_qD4_ydv1E7rXwLsj7
X-Proofpoint-ORIG-GUID: BU50fZgp4H-Utp_qD4_ydv1E7rXwLsj7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAyMyBTYWx0ZWRfXy124aTrBbX7Q uM1Pi9kbcFbSRuWzxdfDXz3kv9t2bjBuI10JKS/LAxTdCjfmfij9Yx2+gFxfB7lOhvpzJDkYCCM CxNB7o0oyFrWQGc0I8GQHxmc5lip7Yb0qqdj7WDDbBcoBGK2uVOZkI9VOP0TTZxrUgU48Duh8MA
 O6afDDVT9eWoo/lVBSpZe182Lbj6sAy6ksXSae8jgDvnAsv4nKW9kbvYEMDYzStZcCS0FgkuAzF b+D+vOV108nz60aJhN6CUQybWtOaaLQf0VvroXwCit2X6fsWv+rrHMDMTPakbU1Nu9CqHyXRdc5 7j3JqkS6a6KMEv4/u00C/QiB0VyDTb/UhMDQ5SZXYZd64pKd8z0m5d9+U7VHwucu8+3pzysehQL
 tuutCGIFB/ISUOLVnW7akrRduoQtCO8FZFe35NuwtsL3sZwtEq+ZRX1BfZYKxU1d6Oo22cAj
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130023

From: Filipe Manana <fdmanana@suse.com>

commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.

When using the flushoncommit mount option, during almost every transaction
commit we trigger a warning from __writeback_inodes_sb_nr():

  $ cat fs/fs-writeback.c:
  (...)
  static void __writeback_inodes_sb_nr(struct super_block *sb, ...
  {
        (...)
        WARN_ON(!rwsem_is_locked(&sb->s_umount));
        (...)
  }
  (...)

The trace produced in dmesg looks like the following:

  [947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
  [947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
  [947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
  [947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
  [947.502097] Code: 24 10 4c 89 44 24 18 c6 (...)
  [947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
  [947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
  [947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
  [947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
  [947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
  [947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
  [947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
  [947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
  [947.571072] Call Trace:
  [947.572354]  <TASK>
  [947.573266]  btrfs_commit_transaction+0x1f1/0x998
  [947.576785]  ? start_transaction+0x3ab/0x44e
  [947.579867]  ? schedule_timeout+0x8a/0xdd
  [947.582716]  transaction_kthread+0xe9/0x156
  [947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
  [947.590104]  kthread+0x131/0x139
  [947.592168]  ? set_kthread_struct+0x32/0x32
  [947.595174]  ret_from_fork+0x22/0x30
  [947.597561]  </TASK>
  [947.598553] ---[ end trace 644721052755541c ]---

This is because we started using writeback_inodes_sb() to flush delalloc
when committing a transaction (when using -o flushoncommit), in order to
avoid deadlocks with filesystem freeze operations. This change was made
by commit ce8ea7cc6eb313 ("btrfs: don't call btrfs_start_delalloc_roots
in flushoncommit"). After that change we started producing that warning,
and every now and then a user reports this since the warning happens too
often, it spams dmesg/syslog, and a user is unsure if this reflects any
problem that might compromise the filesystem's reliability.

We can not just lock the sb->s_umount semaphore before calling
writeback_inodes_sb(), because that would at least deadlock with
filesystem freezing, since at fs/super.c:freeze_super() sync_filesystem()
is called while we are holding that semaphore in write mode, and that can
trigger a transaction commit, resulting in a deadlock. It would also
trigger the same type of deadlock in the unmount path. Possibly, it could
also introduce some other locking dependencies that lockdep would report.

To fix this call try_to_writeback_inodes_sb() instead of
writeback_inodes_sb(), because that will try to read lock sb->s_umount
and then will only call writeback_inodes_sb() if it was able to lock it.
This is fine because the cases where it can't read lock sb->s_umount
are during a filesystem unmount or during a filesystem freeze - in those
cases sb->s_umount is write locked and sync_filesystem() is called, which
calls writeback_inodes_sb(). In other words, in all cases where we can't
take a read lock on sb->s_umount, writeback is already being triggered
elsewhere.

An alternative would be to call btrfs_start_delalloc_roots() with a
number of pages different from LONG_MAX, for example matching the number
of delalloc bytes we currently have, in which case we would end up
starting all delalloc with filemap_fdatawrite_wbc() and not with an
async flush via filemap_flush() - that is only possible after the rather
recent commit e076ab2a2ca70a ("btrfs: shrink delalloc pages instead of
full inodes"). However that creates a whole new can of worms due to new
lock dependencies, which lockdep complains, like for example:

[ 8948.247280] ======================================================
[ 8948.247823] WARNING: possible circular locking dependency detected
[ 8948.248353] 5.17.0-rc1-btrfs-next-111 #1 Not tainted
[ 8948.248786] ------------------------------------------------------
[ 8948.249320] kworker/u16:18/933570 is trying to acquire lock:
[ 8948.249812] ffff9b3de1591690 (sb_internal#2){.+.+}-{0:0}, at: find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.250638]
               but task is already holding lock:
[ 8948.251140] ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.252018]
               which lock already depends on the new lock.

[ 8948.252710]
               the existing dependency chain (in reverse order) is:
[ 8948.253343]
               -> #2 (&root->delalloc_mutex){+.+.}-{3:3}:
[ 8948.253950]        __mutex_lock+0x90/0x900
[ 8948.254354]        start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.254859]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.255408]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
[ 8948.255942]        btrfs_mksubvol+0x380/0x570 [btrfs]
[ 8948.256406]        btrfs_mksnapshot+0x81/0xb0 [btrfs]
[ 8948.256870]        __btrfs_ioctl_snap_create+0x17f/0x190 [btrfs]
[ 8948.257413]        btrfs_ioctl_snap_create_v2+0xbb/0x140 [btrfs]
[ 8948.257961]        btrfs_ioctl+0x1196/0x3630 [btrfs]
[ 8948.258418]        __x64_sys_ioctl+0x83/0xb0
[ 8948.258793]        do_syscall_64+0x3b/0xc0
[ 8948.259146]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 8948.259709]
               -> #1 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}:
[ 8948.260330]        __mutex_lock+0x90/0x900
[ 8948.260692]        btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
[ 8948.261234]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
[ 8948.261766]        btrfs_set_free_space_cache_v1_active+0x38/0x60 [btrfs]
[ 8948.262379]        btrfs_start_pre_rw_mount+0x119/0x180 [btrfs]
[ 8948.262909]        open_ctree+0x1511/0x171e [btrfs]
[ 8948.263359]        btrfs_mount_root.cold+0x12/0xde [btrfs]
[ 8948.263863]        legacy_get_tree+0x30/0x50
[ 8948.264242]        vfs_get_tree+0x28/0xc0
[ 8948.264594]        vfs_kern_mount.part.0+0x71/0xb0
[ 8948.265017]        btrfs_mount+0x11d/0x3a0 [btrfs]
[ 8948.265462]        legacy_get_tree+0x30/0x50
[ 8948.265851]        vfs_get_tree+0x28/0xc0
[ 8948.266203]        path_mount+0x2d4/0xbe0
[ 8948.266554]        __x64_sys_mount+0x103/0x140
[ 8948.266940]        do_syscall_64+0x3b/0xc0
[ 8948.267300]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 8948.267790]
               -> #0 (sb_internal#2){.+.+}-{0:0}:
[ 8948.268322]        __lock_acquire+0x12e8/0x2260
[ 8948.268733]        lock_acquire+0xd7/0x310
[ 8948.269092]        start_transaction+0x44c/0x6e0 [btrfs]
[ 8948.269591]        find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.270087]        btrfs_reserve_extent+0x14b/0x280 [btrfs]
[ 8948.270588]        cow_file_range+0x17e/0x490 [btrfs]
[ 8948.271051]        btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
[ 8948.271586]        writepage_delalloc+0xb5/0x170 [btrfs]
[ 8948.272071]        __extent_writepage+0x156/0x3c0 [btrfs]
[ 8948.272579]        extent_write_cache_pages+0x263/0x460 [btrfs]
[ 8948.273113]        extent_writepages+0x76/0x130 [btrfs]
[ 8948.273573]        do_writepages+0xd2/0x1c0
[ 8948.273942]        filemap_fdatawrite_wbc+0x68/0x90
[ 8948.274371]        start_delalloc_inodes+0x17f/0x400 [btrfs]
[ 8948.274876]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.275417]        flush_space+0x1f2/0x630 [btrfs]
[ 8948.275863]        btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
[ 8948.276438]        process_one_work+0x252/0x5a0
[ 8948.276829]        worker_thread+0x55/0x3b0
[ 8948.277189]        kthread+0xf2/0x120
[ 8948.277506]        ret_from_fork+0x22/0x30
[ 8948.277868]
               other info that might help us debug this:

[ 8948.278548] Chain exists of:
                 sb_internal#2 --> &fs_info->delalloc_root_mutex --> &root->delalloc_mutex

[ 8948.279601]  Possible unsafe locking scenario:

[ 8948.280102]        CPU0                    CPU1
[ 8948.280508]        ----                    ----
[ 8948.280915]   lock(&root->delalloc_mutex);
[ 8948.281271]                                lock(&fs_info->delalloc_root_mutex);
[ 8948.281915]                                lock(&root->delalloc_mutex);
[ 8948.282487]   lock(sb_internal#2);
[ 8948.282800]
                *** DEADLOCK ***

[ 8948.283333] 4 locks held by kworker/u16:18/933570:
[ 8948.283750]  #0: ffff9b3dc00a9d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
[ 8948.284609]  #1: ffffa90349dafe70 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
[ 8948.285637]  #2: ffff9b3e14db5040 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}, at: btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
[ 8948.286674]  #3: ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
[ 8948.287596]
              stack backtrace:
[ 8948.287975] CPU: 3 PID: 933570 Comm: kworker/u16:18 Not tainted 5.17.0-rc1-btrfs-next-111 #1
[ 8948.288677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[ 8948.289649] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
[ 8948.290298] Call Trace:
[ 8948.290517]  <TASK>
[ 8948.290700]  dump_stack_lvl+0x59/0x73
[ 8948.291026]  check_noncircular+0xf3/0x110
[ 8948.291375]  ? start_transaction+0x228/0x6e0 [btrfs]
[ 8948.291826]  __lock_acquire+0x12e8/0x2260
[ 8948.292241]  lock_acquire+0xd7/0x310
[ 8948.292714]  ? find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.293241]  ? lock_is_held_type+0xea/0x140
[ 8948.293601]  start_transaction+0x44c/0x6e0 [btrfs]
[ 8948.294055]  ? find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.294518]  find_free_extent+0x141e/0x1590 [btrfs]
[ 8948.294957]  ? _raw_spin_unlock+0x29/0x40
[ 8948.295312]  ? btrfs_get_alloc_profile+0x124/0x290 [btrfs]
[ 8948.295813]  btrfs_reserve_extent+0x14b/0x280 [btrfs]
[ 8948.296270]  cow_file_range+0x17e/0x490 [btrfs]
[ 8948.296691]  btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
[ 8948.297175]  ? find_lock_delalloc_range+0x247/0x270 [btrfs]
[ 8948.297678]  writepage_delalloc+0xb5/0x170 [btrfs]
[ 8948.298123]  __extent_writepage+0x156/0x3c0 [btrfs]
[ 8948.298570]  extent_write_cache_pages+0x263/0x460 [btrfs]
[ 8948.299061]  extent_writepages+0x76/0x130 [btrfs]
[ 8948.299495]  do_writepages+0xd2/0x1c0
[ 8948.299817]  ? sched_clock_cpu+0xd/0x110
[ 8948.300160]  ? lock_release+0x155/0x4a0
[ 8948.300494]  filemap_fdatawrite_wbc+0x68/0x90
[ 8948.300874]  ? do_raw_spin_unlock+0x4b/0xa0
[ 8948.301243]  start_delalloc_inodes+0x17f/0x400 [btrfs]
[ 8948.301706]  ? lock_release+0x155/0x4a0
[ 8948.302055]  btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
[ 8948.302564]  flush_space+0x1f2/0x630 [btrfs]
[ 8948.302970]  btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
[ 8948.303510]  process_one_work+0x252/0x5a0
[ 8948.303860]  ? process_one_work+0x5a0/0x5a0
[ 8948.304221]  worker_thread+0x55/0x3b0
[ 8948.304543]  ? process_one_work+0x5a0/0x5a0
[ 8948.304904]  kthread+0xf2/0x120
[ 8948.305184]  ? kthread_complete_and_exit+0x20/0x20
[ 8948.305598]  ret_from_fork+0x22/0x30
[ 8948.305921]  </TASK>

It all comes from the fact that btrfs_start_delalloc_roots() takes the
delalloc_root_mutex, in the transaction commit path we are holding a
read lock on one of the superblock's freeze semaphores (via
sb_start_intwrite()), the async reclaim task can also do a call to
btrfs_start_delalloc_roots(), which ends up triggering writeback with
calls to filemap_fdatawrite_wbc(), resulting in extent allocation which
in turn can call btrfs_start_transaction(), which will result in taking
the freeze semaphore via sb_start_intwrite(), forming a nasty dependency
on all those locks which can be taken in different orders by different
code paths.

So just adopt the simple approach of calling try_to_writeback_inodes_sb()
at btrfs_start_delalloc_flush().

Link: https://lore.kernel.org/linux-btrfs/20220130005258.GA7465@cuci.nl/
Link: https://lore.kernel.org/linux-btrfs/43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com/
Link: https://lore.kernel.org/linux-btrfs/6833930a-08d7-6fbc-0141-eb9cdfd6bb4d@gmail.com/
Link: https://lore.kernel.org/linux-btrfs/20190322041731.GF16651@hungrycats.org/
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
[ add more link reports ]
Signed-off-by: David Sterba <dsterba@suse.com>
[Minor context change fixed]
Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/btrfs/transaction.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 21a5a963c70e..8c0703f8037b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2021,16 +2021,24 @@ static inline int btrfs_start_delalloc_flush(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 
 	/*
-	 * We use writeback_inodes_sb here because if we used
+	 * We use try_to_writeback_inodes_sb() here because if we used
 	 * btrfs_start_delalloc_roots we would deadlock with fs freeze.
 	 * Currently are holding the fs freeze lock, if we do an async flush
 	 * we'll do btrfs_join_transaction() and deadlock because we need to
 	 * wait for the fs freeze lock.  Using the direct flushing we benefit
 	 * from already being in a transaction and our join_transaction doesn't
 	 * have to re-take the fs freeze lock.
+	 *
+	 * Note that try_to_writeback_inodes_sb() will only trigger writeback
+	 * if it can read lock sb->s_umount. It will always be able to lock it,
+	 * except when the filesystem is being unmounted or being frozen, but in
+	 * those cases sync_filesystem() is called, which results in calling
+	 * writeback_inodes_sb() while holding a write lock on sb->s_umount.
+	 * Note that we don't call writeback_inodes_sb() directly, because it
+	 * will emit a warning if sb->s_umount is not locked.
 	 */
 	if (btrfs_test_opt(fs_info, FLUSHONCOMMIT)) {
-		writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
+		try_to_writeback_inodes_sb(fs_info->sb, WB_REASON_SYNC);
 	} else {
 		struct btrfs_pending_snapshot *pending;
 		struct list_head *head = &trans->transaction->pending_snapshots;
-- 
2.34.1


