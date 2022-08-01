Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BFF586660
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiHAIbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiHAIbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 04:31:31 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A826D6
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 01:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659342690; x=1690878690;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uWj2alcxVm/QbH6tZCWFs29y+NRJMnWOxB31gBgQsC8=;
  b=HXd2eogSrO78ikmQ5Uf1AytfqflXizWiKbHuVMr7OKa2OnnlwscrDCh2
   StZSy+Ap9UNjLWvVEmjLF3etv76gRHnhninMc1xIoJoBhRVfXA+6RZv+E
   2TOK3Uj4qimkbds3PJBhGbRy6QMOKF6r5NPHetD2azf26JsAIdLbt33lF
   0s0tqWFDxiAnf79p4hm3xbaoO8YmBRdhLu9TOj9FDXLzRNFln9DRVJOn2
   r1D/cVxaZ/oP4cosKGXF0JbTkh+Rj4z6NFTK45c+Ttmh+oxt7ZX/SEf+P
   jYY3E1QR/cnONJWd2sj27fes6xt9g//nRaN2o/O25gypf2ZZm3JMXWJe9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654531200"; 
   d="scan'208";a="208045728"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2022 16:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1ytwvHqbJd4kwZFSfOsRrVqBFv98ErlZqrH6z6BaL2xttWhjR3E3SJyohwe/DcBNkAedi9p2geKlsIV0FlQEP3klsMbsC7FfSFqrPi+NJSsm0RXOJHQaujOvvmAmbEHvXn0rIEy18MRak4U4O5P+O4+ncdHXA3CTou0Ej5neBcuuI2kaGmrxADV0pmcP9mnxbQyk/zQpsnFc2J7AErzBrafVNehVd+Wqu3lWCUHOOWVUmn7lltrvqmOX7YgqOCmLVRB122yID0o5aXlri19hKpIELV6/Im2Gm68VMqBsj+ix5exLIgWuQ/x/jm82c9UVndNG3YJiVyXanbYy3Zalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBVj/r38Zg7VwB0WWJP5TklURZxfsKvOwxc5oN3e+1Y=;
 b=Kem/Z3445uYDXfyN22+G+ptCYK4nxwLSahQ7DczCQvIU6zX56sj7VTAcroZcLLG9lg6yeh9q2jWcp7EvgW5sdcT76R9MwMZVbQWVVqGHhCG/ll7/uQWgyVyIqU/2r8wwRnNEfDYiH+iziRdI+kP7lEXMmdficf4/oBZs7kDmfNA+KsddXv5Rat9CVDejjM/iJnkyeKNXm9t2ArmBNEfJsjzLZsZE+L8x0Sd0OxqqEaIsGLj8cKcDAeTvwKiisFmmYFNHPbYRP9+l780auU7HLM3KLQiERdZ6PEC1j7TQ1EF99i8fAJ8ugicgBLviTVPh5pisWE18yzabclVF+KStbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBVj/r38Zg7VwB0WWJP5TklURZxfsKvOwxc5oN3e+1Y=;
 b=iy5ZTe8ZKEcn7CzaR6FoH6NW057oORfxa/iteADplrgBYVlEv8xU+UfVPf2KfXcwAS41nZJR2UV66GllWNWG3DZk7eswIZwEZs3m+N6b+0zp5T5tJfNCIDU7UpY2MSk7UtiRFxMZCXAQmhG5UpC7FBLqwEg+I8MkrPaiOLAjWUo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0552.namprd04.prod.outlook.com (2603:10b6:903:b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Mon, 1 Aug
 2022 08:31:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 08:31:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] btrfs: add checksum implementation selection after
 mount
Thread-Topic: [PATCH v2 3/4] btrfs: add checksum implementation selection
 after mount
Thread-Index: AQHYo3Ne7rTGQjlco069of/daIBVuA==
Date:   Mon, 1 Aug 2022 08:31:28 +0000
Message-ID: <PH0PR04MB74163C285A080F2F0C26D80D9B9A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1659116355.git.dsterba@suse.com>
 <d62b2c8e27a7a38b5e76f1b9d94dfa0fc2fa0dd3.1659116355.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9516ca3c-5d01-4aa3-b566-08da73983aad
x-ms-traffictypediagnostic: CY4PR04MB0552:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lCxA4Uay3ur1wEanJQSqoSkDz80A+Nfu0YhdDf+u+m1uT2EzGsPAdKOb+VcFaQQe2WUdbUzcCfDBAEFGTJEVrJV1M7yDudXPI/iYVv9dR+7C2me8BB/r7A4GsQH3SJPMTpMVzRjmx0c8dTt9n8ye07a+Q3hirSvi97Gsp/KefskuLFU733Ut5f22DCu7not61qnkrPjpoM+M+EQsV6K6U3W90h/yjUUSMBKJ8+pzBmeBkBZGck2bz4aRd6QNLL1UtbNAuXCXKgkDFozRO1HpPJye2qgt6Zjve0K+IZBlnwsH6p7sXs6Aa3zMtchB6kMBfRQmczcudnZDIemwztQYXs7aFiHvrN0HG9UE6THjx0XC2WpufBQbuJVgHIg273R30OMPNjA/zN2XYJGZNLw5QSAnd7jauxl0KPUW5WRIy46bgbit+Z581DFJ4+wpdAtNF2TBCfMgBGgCUAj/8yUBILurzfiQKV4gBP58Aw1sXVK4BHal+t16WNUIh7aVNst0xHB/S8alGKAPNaaVocMv+5Ppv4LLxc62TH3l1vOqyYXGcBu14nd8XRr34QNNNstv8pNDrBHrCkYjGK5+8X/jXv0U8iuhH/UgUuZG+2/J4iUfaeaAA0tcROL3/OI0BYlHImiVe//DGO6AxAnDgQ8iMUDfBcO2O1NlaPKsMaAW7co6RqZu+EmbENPg6xStvC9+OHVbGwVg/6IGvondBFD9y1k7AOjJLWnCfmv/Mpy2fOzq2vleeZB6Sc169cWgGaHBgYRbKYV14WBGuyYdlQoM8FflAUU9NFqMdSchgvHwd9MwTT4r3wVhaunduhQ0fVFp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(4744005)(316002)(9686003)(26005)(38070700005)(5660300002)(52536014)(82960400001)(8936002)(110136005)(76116006)(91956017)(66476007)(66446008)(64756008)(66556008)(66946007)(186003)(122000001)(71200400001)(38100700002)(8676002)(33656002)(41300700001)(478600001)(55016003)(86362001)(7696005)(53546011)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0RKM2tsiIhqyhn9g13wZPmoMWAa4IHIj1nllxrysVsTE4ELiicF4/me93PhV?=
 =?us-ascii?Q?lUbW5tmtdcTvrAtTx5ZC5ZbqDOKG2VyFgtdQ/BFyIxftqUDxrMA9fzaeEliJ?=
 =?us-ascii?Q?T0Rv2ccy6tawDfuwr6nvAxbbAu99O0KwCHHdv6RGs8lN/chWchitzPVaUSZG?=
 =?us-ascii?Q?6VDPRzcXEQt5PqDuRvowBJA2h1zlMMd1g8CK8j3aZBp/YxdebPE0EWZ5gsVk?=
 =?us-ascii?Q?kKhRZ7SAc8wsyNoqWgGZ/d7vkW020EtTn5uP3Lel8FpzZ6EpNdu5BgxCE4pr?=
 =?us-ascii?Q?q4GZd3Cnog2C7pPzLUv9wjDW9HaXPCbzCNrQs5dEqLRnuyefyvmQdWMpSW02?=
 =?us-ascii?Q?a2wjlAegvC3xMuS0YFcYBLVmV7mbChqyUZuIOxlRNeqWEe6gI+Wr5nl8fOjT?=
 =?us-ascii?Q?WYLXIjzem2yPORCgrXsYy2aFfiQ5+VZIlXlevV4ax/PS19gQ2OHX7huusmON?=
 =?us-ascii?Q?/QX7NFaAYWs5L1ne0te+bjPWiS8s0XWlS/JDTL7rIBq2ZT4TG9FrRlwLnVOG?=
 =?us-ascii?Q?vvZxsDYIWYtA02U1lsSbpoXIVSsiKjJPxEF/f9QjMZV0I4slEN1iBTWvR4az?=
 =?us-ascii?Q?ByR4dK4J8xRZCVnlo1MiYkh6TR9rjVJYCWVGBkwbXhtvcKBWhLW+qhaBdhU+?=
 =?us-ascii?Q?ljXufD3HbnWYNcVYXpQXP7CqeFJabxMtqw0VBbRfy/7UNMIwOiQ8vCWXhsrO?=
 =?us-ascii?Q?8nVQ+GOL9lVr61QDCJkexBOh9FbzvpsKxRdqPCvbVbS5DXnHfGLS5vdZpqVp?=
 =?us-ascii?Q?R78s1dgdalUJ2Le4F1ypamrS/jYb9rlXAEetcLt0/P4Y2JbWFendVWmJEfvQ?=
 =?us-ascii?Q?re9nCgG8tjNhy4OHbSSP5er9BybPtSBm5PLFNAM5DYWL2l0iOHfxqsRvaBlk?=
 =?us-ascii?Q?WKuqNpQt/BCGkUqchHXRMcqG37HzMPzVCZBZozpJcUfGAftONs/rrMHYJuHA?=
 =?us-ascii?Q?qhfCUBKxBYR2zuyjuvtKoFHiNjkxPFGl/qWXLzj0ehKLPIagCb5d3G5WAt93?=
 =?us-ascii?Q?0uHNN2vHq40XE08OEe07ey+bSEQOM7xmYGFyf7GP384HYQcHyTrVdJcVpxxq?=
 =?us-ascii?Q?0naDV1wT7g1eCrzmp5aWFZ1ePo2wZ3sNo/Aap+ilv34C6C0I8cGkQgSfF7RF?=
 =?us-ascii?Q?eYdu8UGPacox+QO7Wbwu8kpoU1V12vWVsBNyUW2GL0KSaWDukDH+Dur8kUo4?=
 =?us-ascii?Q?W0y3S4f1f6ubYqe7pwdXkxNCJqfsux3FRdMEbX2BFPc2F2vcyDQkk/b2V5nv?=
 =?us-ascii?Q?cQ5pnKztgOt8er7rmU4/YcOlbILBJYePD8L5IL4GYbhCA6kIMcy47vrmZnpQ?=
 =?us-ascii?Q?dOT0RINgxIcx402eA1gY880IaI5Fur2iL0aunBJnWOfsGP6XTMAqf7F4T7X6?=
 =?us-ascii?Q?1GjdkkcXQ+nvOlh0+/GM2dnDeN9Fc4z272snAarDMeGqisFv3PthF+bDXnLM?=
 =?us-ascii?Q?exqjPw8UdJVBTJrjqeATfrsoH4ydVrpT3GLsfo3svkTGQ616H4YJmHXFP6XG?=
 =?us-ascii?Q?HhIfMNBZb4xCc+0Uh7BkSFv1ZnQFc/ax9xvBG1QnTgwuMVFSwIkAlLbE9jKM?=
 =?us-ascii?Q?zRp+MtdXAe9Npp29QI+XVTH1QpwrWiMc6mtoBjsA06wILGJDYhcEOL5BQR89?=
 =?us-ascii?Q?o0ruAF7A/P9O+b1nyZT284A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9516ca3c-5d01-4aa3-b566-08da73983aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 08:31:28.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMayddpRCnyQe0q9Ck1ORZOl2WTJfYiFR3EtbYw0aVPDxlP4FdYRPXho5+9TrvboEAnxr7yVQ3LnrYUBikWLWurav0R+/pDzvpyXUdekDtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0552
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29.07.22 19:48, David Sterba wrote:=0A=
> static bool strmatch(const char *buffer, const char *string);=0A=
> +=0A=
> +static ssize_t btrfs_checksum_store(struct kobject *kobj,=0A=
> +				    struct kobj_attribute *a,=0A=
> +				    const char *buf, size_t len)=0A=
> +{=0A=
> +	struct btrfs_fs_info *fs_info =3D to_fs_info(kobj);=0A=
> +=0A=
> +	if (!fs_info)=0A=
> +		return -EPERM;=0A=
> +=0A=
> +	/* Pick the best available, generic or accelerated */=0A=
> +	if (strmatch(buf, csum_impl[CSUM_DEFAULT])) {=0A=
=0A=
Can't you use sysfs_streq() here?=0A=
