Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0436467B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhDSO4v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 10:56:51 -0400
Received: from mx0b-002ab301.pphosted.com ([148.163.154.99]:44645 "EHLO
        mx0b-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhDSO4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 10:56:49 -0400
Received: from pps.filterd (m0118794.ppops.net [127.0.0.1])
        by mx0b-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JEqO4T019779;
        Mon, 19 Apr 2021 10:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps-02182019;
 bh=5pW2YOASnRI6ufqn1QPEu/z3MpfAN1AY2ph2uEkhB+I=;
 b=UOwKDJKyZ4hNp6CGiR+jjYeid+lOIRkxY+mohxhD9Luo66iytxUoNf9+dEPQVM87WrB0
 eSexUwQIevE5FjG482kuGyUpkc5b+kj/HSP9awwQBp4yr87JPtumhjduiGrYVHpOlCTp
 Nu2EIIcnIeAKy2x9Ec+ochFhOcOHmYI06+Daev29F1N8g4X1BnPFacPHWPehSBVJvcND
 MWbnqZQa+RhbCbi43afxSP3eZUIclG1t4eB/gJ4+kG8j6ggakCeAwdpz0usaxF2Rnx+P
 r0E0L6Na43wzCGhb25QmG0y5Lnosl/kWTnqdfuGi2txyWdOVd8gevewTkrebdakttWfG Gg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-002ab301.pphosted.com with ESMTP id 380d5c0w9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 10:56:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYoe50Sr1An3yBMkI3qniNi+xn+hKgLGuQWMkq1t45zMy1JwoX+UIL2waKZiNkIVwAPVZvh3wwru5ZVGWQ8rGSNrE5YmDBjKEkjyGsm1SNCupvyw4wifBtQr8TjSyI8TxuWb2IByYZJvwA6INwtOktTgV7u5r2STZvL6G1XdvmgXeXvARXCFn51/PtdsPT0Hzx0KDN2Fv6Q2Z4gmO/7o/KDbIvTPKBWopjWVcpMb9VgafR44vaXWkT6Osmlbm5apt4SrX5TT6lrNnVFODOEobS8wPF0KQBXJpyfarOdYqUNX16nK3o7VbGIJ/roMhWH4SQf+pIhhlm2qogT1KurRlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pW2YOASnRI6ufqn1QPEu/z3MpfAN1AY2ph2uEkhB+I=;
 b=N1vvJX+DlP1jMU9cMiS4jClpTU0AeUY3nio7dUg7PmzT2w+QVL133Ax2PjMJ8oB6Qw2LxpkHrC2jPSceghf6Xpg/8YuW5Gb3Vem3SBMmHc8GoMHsb9+UhV9Jn0rLZ0pLLWoIoHuRL27g6IEl/ypaYIc34JE0erObaWWdMRS7Kow4SqDAUrvlmgF4BrSDczPyEHsmRijHnU2l0P71KD/gY5m/1lZxO+qOO6+/U07GpuCSc8EOmaObGlx6ml8eApKDZK9CYTpBDR4chseAV+0z0r971v/FsVU5p2hjxIxVdlcFw8GQOtGG1mSk1IXKkOls6L3s2xaiuezb2w9i1B8Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pW2YOASnRI6ufqn1QPEu/z3MpfAN1AY2ph2uEkhB+I=;
 b=eKqcoTktNoz24DGRJApZ8J1fNLXe9Z5Z+oTj18juO0bu1E492KaXe3UrFcXxRDikbTSnhWOMZnkHDFVAgx4B3Ar6oNxetpDnqcIq8JyJpvp2ccTfY5Zp0MMAsmEn9xml3JFtZhuFzrUH7HHlPsGacaUhG10sKu8zCQ158497WPw=
Received: from SN6PR01MB4269.prod.exchangelabs.com (2603:10b6:805:ad::23) by
 SN2PR01MB2094.prod.exchangelabs.com (2603:10b6:804:b::16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 14:56:13 +0000
Received: from SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b]) by SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b%5]) with mapi id 15.20.4042.018; Mon, 19 Apr 2021
 14:56:13 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7y6q35F6AgAPucjqAAAh5gIAAFd71
Date:   Mon, 19 Apr 2021 14:56:13 +0000
Message-ID: <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>,<41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
In-Reply-To: <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [76.67.142.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 627ccb28-a7c3-4a0d-eaa4-08d9034346c3
x-ms-traffictypediagnostic: SN2PR01MB2094:
x-microsoft-antispam-prvs: <SN2PR01MB209410F8E5486B23C043B358F3499@SN2PR01MB2094.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kwf2b2gsKZa9jx3YzMxTUbtfg46nDD7i+mXepXfTUkjj2mmTs0rG7/lBtgGPgCj36EQXWeSbgAKnqrkymbyZZrtpFteQjDg0r0G1Q+bS3nQ0mGl748n/okS/QD2Hv2Ua7ltDZHAshzPdC5l/hqNoFT6FLdwsJQFbSHQiUXS8vY5YS42pwx+C3IPNY9tMouDRYidCLqlTUpQvHaMlR97EhePXL+zm7F1LXMTY5kp4oxvq5PHhuBitibNbcRJpsME6gnZeJpVWSqDJOdlTjd81wJEXZFstMWyN6fWTD2ASzAW4hlDJaOf2s2wQd4TCB+g+XaaTv95x1yO0ObxgC36PfVS89kkO2vzAGGLbhX73vbFGBJvS6nDrw4FlYhtg3VauLqkl+9w6jnSbjYdKezW72Q6OUYCCgeWhj+Ei9Czsn2+hVissNf+xkbIF4VDVCz//NZ7HwMzfKATLj7MgWJiTa8dIEpRuFxv7ATtmEUePejUbXr5mc4V9JTr24OF3Jjhd93qdB+j3DS+viTD5dAgg3TeVzLYbtNJup8I8fH2uFKOKdTJKIMglchy8PDNON55t/UoUWxt+vBFYv3HWUnEflavpqj5DeOtvTR8BDHddgGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4269.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(39850400004)(396003)(478600001)(83380400001)(316002)(55016002)(110136005)(38100700002)(8936002)(91956017)(76116006)(6506007)(186003)(8676002)(26005)(9686003)(52536014)(7696005)(5660300002)(122000001)(66556008)(66946007)(86362001)(66446008)(64756008)(66476007)(33656002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?EoeOZfes4e6tpejS8g5jqLevoJn0F2RxgeOL6VLJm5wLhReaJBWGGBMhZS?=
 =?iso-8859-1?Q?0Cyftqz01IU3U6ksitmRhRNcY1R5CKfic4KQxdY71MuQkyszuaR2UaWaz8?=
 =?iso-8859-1?Q?ZvpEqC+gWGtu0HJ5brqHTyoM5inDiAfn1eegLbdotOgqesgk2YyZWqAiJw?=
 =?iso-8859-1?Q?t8KTxBoy7E183wX6pfB7p2nKgJ+a/GwWofaR3jyc2ueysLdzZ+Tn/bZMBd?=
 =?iso-8859-1?Q?QOoHzGTwKSkY737mZ0l/nenMgJaXT59/NHiQIvDI4Tu84DN8xTfqZl/U/i?=
 =?iso-8859-1?Q?pLwnEAHqw8xZB3LTXDzE5z++XVjGFEK48q3K6tqbjshfqQ6zHKYdYM8vQy?=
 =?iso-8859-1?Q?/y6J+ekqKfOfbgeGKINRIPncgGk2Tx2XX63uvF81sBrni7cFLXG9EnqN2X?=
 =?iso-8859-1?Q?K4dhUAJq5pLeEptOmHwVPbeMtn9YISIXF7ptCNswowtv4raZczYw+AUdhB?=
 =?iso-8859-1?Q?ZTI0Ujynx0946DC2fQ8SmpduFM+OWdmt2NxaAD/Ge4unaUGmXw63zPtVaz?=
 =?iso-8859-1?Q?3NJ5IahkfW7Gkm6FKGG7t0u2hAoR1T8ClurHCFPifJtf6FEVJNuxCjT7i/?=
 =?iso-8859-1?Q?rz5uA9uTY0yMiYcqWzl1ZA5gxyrbQRmsxdnBjGvV+3M5og3qnTa0vuALNC?=
 =?iso-8859-1?Q?F21c0RUTx5MNsit8S/uCiZZQj7gRLorFoAQJtg1gR5UIgQVvXegWtr+M57?=
 =?iso-8859-1?Q?2v2BJIWYu+JPcnHxzOzIeMuzJIELaY4akNVJT6lJu2A+/V4jIeUbN4imuj?=
 =?iso-8859-1?Q?2bzdCEL18g8tn996xLTfGYO5JrBPwT2xhiPiZznL0qejt4CPjWNwwG2hgv?=
 =?iso-8859-1?Q?Y8LrjXducaufNBESIiAGZt2d8ujWTDQclU6YijUZM7a4JkagRlZSKF3mU8?=
 =?iso-8859-1?Q?ZB8Gl8TINI4dgJx989KXZTrD9qAAnw81DfXls/p6YXiM+rScjsdnveMn4h?=
 =?iso-8859-1?Q?yUyHsNUHzajdNOi318SLtlHfSMS6SCZ4ug6A90/3pKDhLKn7hCgoFBJe0T?=
 =?iso-8859-1?Q?zlE22/juXqomsqGhX2yF8gigR2oTPWrVH8iwzBzQpTxOoFPtp8kIQ7uwPu?=
 =?iso-8859-1?Q?yifHnyLOIxPADolFtM0H98+rlCvgGAbks1ct/VDBK3pl6643PuR0izEenr?=
 =?iso-8859-1?Q?wuX3MO+03wFvmM2rFoSv3kcaL8XMOb+S6vD01faQOIj84wDk8V9vSomOfl?=
 =?iso-8859-1?Q?CW4/K25VRfT4gSBeP7DnGwzQ87gszxmFX8f5aTrFsKsjOjkKIMZW7xP1J8?=
 =?iso-8859-1?Q?WBfMR6uHzlYXiTaRBBf2pHsWu2kWEj5TKf/sLizLwLRWRp2+hUsUamg0fV?=
 =?iso-8859-1?Q?x2X9kak6cCvqULHp3i0zgTZdeBTJvqO/0ip2ErFmoa0NcN8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4269.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627ccb28-a7c3-4a0d-eaa4-08d9034346c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 14:56:13.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFS9dH4Vu/75XckxGgEygRH4AISHQiDmQK0Ms9AYNovCh/fmN+llecWAPdR86B2zL4EnyVrkPys3r4cJDNjBuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR01MB2094
X-Proofpoint-ORIG-GUID: gyMr14BTizbi3YhCU3uu09cRIXWx82DS
X-Proofpoint-GUID: gyMr14BTizbi3YhCU3uu09cRIXWx82DS
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190103
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> My bad, wrong number.=0A=
>=0A=
> The correct number command is:=0A=
> # btrfs ins dump-tree -b 790151168 /dev/loop0p3=0A=
=0A=
=0A=
root@debug:~# btrfs ins dump-tree -b 790151168 /dev/loop0p3=0A=
btrfs-progs v5.7 =0A=
leaf 790151168 items 10 free space 15237 generation 219603 owner TREE_LOG=
=0A=
leaf 790151168 flags 0x1(WRITTEN) backref revision 1=0A=
fs uuid 29d53427-f943-43ad-a99e-ac695d225d0b=0A=
chunk uuid 04c4bf25-55ac-487e-97a3-fbdc84961b4a=0A=
	item 0 key (4614 INODE_ITEM 0) itemoff 16123 itemsize 160=0A=
		generation 282 transid 219603 size 0 nbytes 0=0A=
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0=0A=
		sequence 1345948 flags 0x0(none)=0A=
		atime 1610373764.218465480 (2021-01-11 14:02:44)=0A=
		ctime 1617477830.389953334 (2021-04-03 19:23:50)=0A=
		mtime 1617477830.389953334 (2021-04-03 19:23:50)=0A=
		otime 606208.1 (1970-01-08 00:23:28)=0A=
	item 1 key (4614 INODE_REF 1020) itemoff 16101 itemsize 22=0A=
		index 1217 namelen 12 name: brokerStatus=0A=
	item 2 key (4996 INODE_ITEM 0) itemoff 15941 itemsize 160=0A=
		generation 290 transid 219603 size 0 nbytes 0=0A=
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0=0A=
		sequence 4801736 flags 0x0(none)=0A=
		atime 1617304887.496533028 (2021-04-01 19:21:27)=0A=
		ctime 1617477830.681955095 (2021-04-03 19:23:50)=0A=
		mtime 1617477830.681955095 (2021-04-03 19:23:50)=0A=
		otime 0.0 (1970-01-01 00:00:00)=0A=
	item 3 key (4996 INODE_REF 4715) itemoff 15920 itemsize 21=0A=
		index 9 namelen 11 name: scodes.conf=0A=
	item 4 key (5007 INODE_ITEM 0) itemoff 15760 itemsize 160=0A=
		generation 294 transid 219603 size 0 nbytes 18446462598731726987=0A=
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0=0A=
		sequence 476091 flags 0x0(none)=0A=
		atime 1610373772.750632843 (2021-01-11 14:02:52)=0A=
		ctime 1617477826.205928110 (2021-04-03 19:23:46)=0A=
		mtime 1617477826.205928110 (2021-04-03 19:23:46)=0A=
		otime 0.0 (1970-01-01 00:00:00)=0A=
	item 5 key (5007 INODE_REF 4727) itemoff 15732 itemsize 28=0A=
		index 0 namelen 0 name: =0A=
		index 0 namelen 0 name: =0A=
		index 0 namelen 294 name: =0A=
	item 6 key (5041 INODE_ITEM 0) itemoff 15572 itemsize 160=0A=
		generation 295 transid 219603 size 4096 nbytes 4096=0A=
		block group 0 mode 100600 links 1 uid 1000 gid 1000 rdev 0=0A=
		sequence 321954 flags 0x0(none)=0A=
		atime 1610373832.763235044 (2021-01-11 14:03:52)=0A=
		ctime 1617477815.541863825 (2021-04-03 19:23:35)=0A=
		mtime 1617477815.541863825 (2021-04-03 19:23:35)=0A=
		otime 0.0 (1970-01-01 00:00:00)=0A=
	item 7 key (5041 INODE_REF 4727) itemoff 15544 itemsize 28=0A=
		index 12 namelen 18 name: health_metrics.txt=0A=
	item 8 key (5041 EXTENT_DATA 0) itemoff 15491 itemsize 53=0A=
		generation 219603 type 1 (regular)=0A=
		extent data disk byte 12746752 nr 4096=0A=
		extent data offset 0 nr 4096 ram 4096=0A=
		extent compression 0 (none)=0A=
	item 9 key (EXTENT_CSUM EXTENT_CSUM 12746752) itemoff 15487 itemsize 4=0A=
		range start 12746752 end 12750848 length 4096=0A=
