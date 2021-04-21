Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B07C366DF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 16:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhDUOR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 10:17:58 -0400
Received: from mx0a-002ab301.pphosted.com ([148.163.150.161]:2078 "EHLO
        mx0a-002ab301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238683AbhDUOR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 10:17:57 -0400
Received: from pps.filterd (m0118789.ppops.net [127.0.0.1])
        by mx0a-002ab301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13LEHHdZ002448;
        Wed, 21 Apr 2021 10:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps-02182019;
 bh=kI0AQ7g32wsFUvApHQn9aTxv/D50+EIOa8MHHkDvCuc=;
 b=XvH903sLMzZye+RYN1qRKAVl+mnEkDxy+StHdgWNJzWutv+I/08rEcRhL4KYWJSYNLmI
 vv/z71jfmDoC2L+Wp+oN+PR3+UgqX4YDHeBIitABihtJIMFM+GXgZm8js7dKi8PrQxRz
 wJnTeApaMpxWFIx46wpVGHpzcX6mScYm6geYRfhztBESGx5hn4535v72zF65rZNhq++d
 sF7yEO1oqc9KzhTdW3YHVaJrPqIRXYw6OYhy1vgNg+DV89oXb6JGRRgyF6G+2EyAIZJ2
 8rzCBcSkYbk35fPCq43/+Kf+mDN8HIPIdSRP4RGF9CTTh/rWQjn5lC8H1ln5eseVEC5X bw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-002ab301.pphosted.com with ESMTP id 382gmu88py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Apr 2021 10:17:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaMY9Jd9SoN8JiYIzbqUJMt2ZPwIBL2JnVLLKAYL/GZq4M45nyRRmTMqwNKXjg9Z7ifWUDrftGhPhD5rqj2MvmDQqBhNDrfnn6l1tYo7NdfcExbkPhVPGVfMFIgrNSE022x42P7OrB0ETtgIjjN69L4l6F4m+vEk6pfCoi3I7ejmn0Wo0QtZLSv46z9k0Vfvd5WKkalM62QM2cnMrVaRGWOBMWLP6jvCS5tzaC9am4Q4hJESITfrLO32L39alDLS/ZROGr+qgiknNVxeVEApTxl62Sbtb2PBcYenKuBKiGRGMr1L34bLfoyW92fi4SGnHHDefvhqFeb8wbv6eaJNQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI0AQ7g32wsFUvApHQn9aTxv/D50+EIOa8MHHkDvCuc=;
 b=bUi1+l4A345PpaLnf9FwYUw/OyOAAROJYyhuvC5BKiFRk/szFzkxJWVcaSvMIVxmmVMQE23zpg8nYmLgxVYHOS0Fe+YsiPw8GdLTChkAab9mwipLX8HaYzBntk5/nPieJuD5qVRWMVIcRDq/dZCxTmdZSzWCq8phDDEy1kOceAGDSHlnxUt83DZBSdlYq7U0gkpj/jb5xz2FOdCeFdrHsTfJvyINDS2OgNJ91z01/f+W6QMMrSwGoogtbzO3Lqx2yhCmtWRiXjo+7YG4dDojz6vdM8XHy+74A79FD13mn66tUlPuVdmFX7yGIt5vsqtiohHqVSobG/yJwxC4v1/k6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=distech-controls.com; dmarc=pass action=none
 header.from=distech-controls.com; dkim=pass header.d=distech-controls.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=distech-controls.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI0AQ7g32wsFUvApHQn9aTxv/D50+EIOa8MHHkDvCuc=;
 b=DaNmlZo1ctvmqkKoZJ7xn8QeThL09fSdFxzDXXpkImb3zSVMa2+KbQaXhsXGK6V5M02OC4um1rfu2EJu/MrBjcBB2mz3OdTovNC9MWocH9dm0Ea8/0hVxLIfA8rtSJgSbUY1ISA554RhjoqI+C1V5bB55bgvbNLVJvS6CvOnKVg=
Received: from SN6PR01MB4269.prod.exchangelabs.com (2603:10b6:805:ad::23) by
 SA0PR01MB6299.prod.exchangelabs.com (2603:10b6:806:e4::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Wed, 21 Apr 2021 14:17:16 +0000
Received: from SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b]) by SN6PR01MB4269.prod.exchangelabs.com
 ([fe80::a960:87f5:c3ed:da0b%5]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:17:16 +0000
From:   "Gervais, Francois" <FGervais@distech-controls.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <FdManana@suse.com>
Subject: Re: read time tree block corruption detected
Thread-Topic: read time tree block corruption detected
Thread-Index: AQHXMvQIVkE2UJzwZEu4ya+WYER7y6q35F6AgAPucjqAAAh5gIAAFd71gACzewCAAMlBj4AAq2MAgADvGLQ=
Date:   Wed, 21 Apr 2021 14:17:15 +0000
Message-ID: <SN6PR01MB42695BAC2335150797F758C8F3479@SN6PR01MB4269.prod.exchangelabs.com>
References: <DM6PR01MB4265447B51C4FD9CE1C89A3DF34C9@DM6PR01MB4265.prod.exchangelabs.com>
 <666c6ea6-9015-1e50-e8a7-dc5b45cdac3c@gmx.com>
 <SN6PR01MB42690A51D0752719B9F1C6ACF3499@SN6PR01MB4269.prod.exchangelabs.com>
 <41e13913-398a-96b8-0f6f-00cfc83c6304@gmx.com>
 <SN6PR01MB4269861CA9BA4D5E61DF1030F3499@SN6PR01MB4269.prod.exchangelabs.com>
 <709d1a70-e52a-0ff3-8425-f86f18ac0641@gmx.com>
 <BYAPR01MB42641653D21CE9381EDB7CD6F3489@BYAPR01MB4264.prod.exchangelabs.com>,<f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
In-Reply-To: <f88a4913-87d7-830a-04f8-9af860abd747@gmx.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none
 header.from=distech-controls.com;
x-originating-ip: [76.67.142.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb1872db-db6d-441a-466a-08d904d02a5c
x-ms-traffictypediagnostic: SA0PR01MB6299:
x-microsoft-antispam-prvs: <SA0PR01MB629992ED98889B151444236DF3479@SA0PR01MB6299.prod.exchangelabs.com>
x-pp-identifier: acuityo365
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cvsx0kBW+lT1dwow9DOiZIz0qu5TBw0+N2ej9Ondd4By0yXncjNTO8AbhQP4ddjotkSZjMGdhIfbplkxEV01IyMIEO2Ytws+7LuIkr9A45v3NpxMyoLrsfhxE4N0Lr9QXFGO8C1phAstlgFx5Uvp7Jx9u7l3vbDdtSiAzRxvmulb5+kjdw9qdpRweT3xKDV/MMAi2435eFSOO8lBE67Z372xxvOriqIdCWctR/M/TvgjWA86bCkXBXTW+3N0/JMdUBslGaOyZk2kqkV76RtUN7D53bW0qXxdR3zhLzxgSAPm1VpX01qj5MQQJhRgRjpaeMHUelzdXWsWh2N2xee856f96ncH2OmpMWSN9g4+Mei7CX8pnRizCjh+6T5KAljLMNHSepXMPVU2opzZzfHZvoZmX/n8FFkHrk4SeeJThYqTKYa72ij6pGSnhIzdTF7QrGHwbTcb0wq8McQsDeoP5i+4fI+Nx/OzWQKW8+dCbpPzOtE4y/pcT35WdotbVVtdExWrmw9hdeWtclKw7CTmiKqP7+rU2rN0ejl8zc2kOPKeb1YHslXvHjWMhSUs9mn7l+f7/Y4CNM/zZ/9EeA21pxjc5C/KfCjVRS3OyiVPoys=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4269.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(55016002)(478600001)(316002)(83380400001)(71200400001)(9686003)(38100700002)(110136005)(4744005)(76116006)(26005)(186003)(8936002)(91956017)(122000001)(64756008)(8676002)(5660300002)(66446008)(86362001)(52536014)(33656002)(66946007)(66556008)(6506007)(7696005)(2906002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ebZV0LKlzrmHfSsSkOlz+1lbmWvuy5CyriWD/XTR6QTARp+nQf8Yme3rjY?=
 =?iso-8859-1?Q?O2wKKBzHetOE3B8Cq10LDlH6j1Xe/cMK/z7ag2Giyf9jJzpGECOY46FiDq?=
 =?iso-8859-1?Q?NQWlG3H6QhjNGrDZmH+ehvWDnfHX6WodpG1k2aDVKVOPlXzMymJS5fClKp?=
 =?iso-8859-1?Q?YBJ7tHDXEjr/2xd37jxZvWi7/m34J6qTx3avGDsRhgsFlIX08gfUKH2LRq?=
 =?iso-8859-1?Q?b6vty4zefVw6UFyxzbw+70q0RZBdEoGy4kTJrHuJEKJq5Hc2nAiy9XJrly?=
 =?iso-8859-1?Q?wlxYtHUPLxetwFHjjCnYilbBCua2ELk3iV/PU7ltHzciYMGAv9sZCUw7Yi?=
 =?iso-8859-1?Q?yu3rWzLAMCdWXuT1K3mxt5FGpTr2EqFUsf4kiM9ryByVbwPnH8Tny5VgBa?=
 =?iso-8859-1?Q?egni6k8wA7wqAKL2s5cQzwgZGl3Sw/rmebj/f2r7O6hz9HtHidhH3qnbH0?=
 =?iso-8859-1?Q?0wLor6OL+awi9Q3Dr3hV0VC5Sm7EWE7cH4Ah/hcUMkNhcMki/FDHvI4QL8?=
 =?iso-8859-1?Q?91xSolyaB3MyC0/r9V1XfiSl4WxoDdZx3eLdzS2pX5H2avy75qD/g8sfXf?=
 =?iso-8859-1?Q?0BQSuY5qgL/zE6gJCtDYY3p5L8WX9nw49UUGJ7w/v+lwW3KMIkHUrQ9sxk?=
 =?iso-8859-1?Q?AMYZfSeIbtd1iDEufxwVUSeOPC0SoUp+2wZ2NMFX36XcmsW/14c1YfLv5Q?=
 =?iso-8859-1?Q?YEtJlT9nEkK2i6hAhEfUJ4OOq47DYGy6LSulbw23/P34MuGasiRl7krJh9?=
 =?iso-8859-1?Q?cWI16J/IlwbOTC+5Wps+EFpI036mrz9kCHZIyPxIVfrGID6rsXcVeN2Kfv?=
 =?iso-8859-1?Q?sYOEHTOXmJtcgVysREIGCvFasIi0EZcG7SZSS6tfgQrDiLm7go6F9gZkQX?=
 =?iso-8859-1?Q?VH10kJFpznKDCSoZ/yc7ZAdttboamdrol8twhy/sJVE33iZ+n4BdBWXI3A?=
 =?iso-8859-1?Q?3R4+XIIZvaG+SCuLP6KSAQIQvDgHjF/K7H60C2zREvQRiYn/BXXQESJaZF?=
 =?iso-8859-1?Q?7rRyi6vtqQrC4piVxhjiSc+Dh1rGV1gPvTqPTaNPK796VRR1xbwTP83dv1?=
 =?iso-8859-1?Q?7xRbChOkAQR2GlGirVjwlVfvQs44KwWY3UwgC8wvQrierTj7XmsroCIMc1?=
 =?iso-8859-1?Q?FTplE7HOnFCcuPjQgmJScHZ8Fcc+o8wXbI1eb2tbWj8aOcf2OaUoGVfso2?=
 =?iso-8859-1?Q?H4auywliPIckV7H001HvZ71v9QzqTx2N4J4REGHg03kZveBSynqfnJ3EeR?=
 =?iso-8859-1?Q?ZvhL3tYICSGdAyENR2AajjwoeKAKYMa1j7Kekx+ZB3n26g6zgB+QJFYyd7?=
 =?iso-8859-1?Q?lkPzuR5yZ7pVPma8DtkzRmwP78hE3hpmwzcgSbYwvqnLHMM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: distech-controls.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4269.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1872db-db6d-441a-466a-08d904d02a5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 14:17:15.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: caadbe96-024e-4f67-82ec-fb28ff53d16d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbaq5cjjyeaT2Tn9WYhMrTdD94p9gKDxM5SpVa9K8xApGVL0YtlYbsBOn5BLiRQwmxlWDph4HpdDEUpRlfdyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6299
X-Proofpoint-ORIG-GUID: MisGE93VHBvIy0wajC-6lFVMcifYU8Zo
X-Proofpoint-GUID: MisGE93VHBvIy0wajC-6lFVMcifYU8Zo
X-Proofpoint-Processed: True
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxlogscore=809 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210111
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> Would detecting it at runtime with a newer kernel have helped in any way=
 with=0A=
>> the corruption?=0A=
> =0A=
> Yes, newer kernel will reject the write, so such damaged metadata won't =
=0A=
> reach disk.=0A=
> =0A=
> But that's just more graceful than corrupted fs.=0A=
> It will still cause error like transaction aborted.=0A=
> =0A=
> [...]=0A=
> =0A=
>> Could power loss be the cause of this issue?=0A=
> =0A=
> It shouldn't.=0A=
> The log tree can only be exposed by power loss, but it's not designed to =
=0A=
> have such corrupted data on-disk.=0A=
> =0A=
> This normally means some code is wrong when generating log tree.=0A=
=0A=
Alright, for the next step, I feel the best is that we try to reproduce and=
=0A=
get more information as of the events that caused state.=0A=
=0A=
A few questions ,if you want, before we start.=0A=
=0A=
- Anything you would recommend as of configuration of the device?=0A=
  - Should we run a newer kernel than our current v5.4?=0A=
  - Any debug you think would be useful to enable or add?=
