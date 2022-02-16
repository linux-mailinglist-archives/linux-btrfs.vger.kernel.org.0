Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D324B8366
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiBPIyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 03:54:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBPIyC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 03:54:02 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5877B45A4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 00:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645001631; x=1676537631;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=V94UyKxCfWQJ9WnYACfmEYILTDtvjdhTlBIzlpiCq0w=;
  b=mI38kNo64qLd7icTtydDHdsRIWiezkEkZflfBKzS35BX6sLXJBijyfHR
   9CGnyfwwO2Z9sCEbqFYkY9Ld76slqnbYICZd1ydznCs2XJ+7ELzBscd/5
   1o/ySbRdohVDD65A25ytDdKEWvCrZaZ97hp1pVzLHeW5e5SWnPRBMg+Dt
   ZXHVYhYbm7yWwRa9DXWqKNrnLRdP5l5fenqcZX7bARcjBHhLs9zwQVi1H
   RdbJrd1OUV31K2iHpK8zABTirmZBI02DtB/9LdXJ51TDHGFh46gYs94Mm
   wxKDBN+e+aJHkGT1+kA70dh6k8A5JdzgckePvJCISk2VsLtzsYgExq7DC
   A==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="194056231"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 16:53:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4XP+Dwg96tnHcJRG0yD7TKBNGxJfQIB9DAS7aUJepqPN28e5OmAUvsftCIJiz5GAlc5ZGGcoYagFE+mOr2fIBBL+iarATQLKu0wJMbhm0fO8ninSaAaKdQLUTwyuesKV/FcFvdY2Y0fEM9xaeO5Pyr5jhkH7q5YzwoGBA+N9BzdaWsvNaTLBIxBmHKksBEwcJuSE2DGs8Md6UfahaMmh+Kw5ZeW4ldzgShAJAZM/lgZrQdr/Z64KAfNachEcjjgz+y5a1TjEbRFHud6Bb+OhbTTPnTTrIDNNskRXaedvrNgEtuBXcgulgANjSGh1H5clOkCJJucXnW+jL5wgiQnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNYTPImiGR/3eGEcm6/RrHaMXd7MpVInOgEwLDEJIvc=;
 b=B8dvkY87iQWar1mFCvSx+C1ic5M5QA0/3zelA2aBxV50IXbc3vptxqLjAF65bSRMr2NVeGCvoL7e37BgpukYVOHTvb/EpOTLjjQO8QulOZa/4NuGxHKOtLZNR/MmivOhisU54nVndkCaLRCEejF1rqI2hgkt3HG5WsvJR5KC0iuEekJRIC2swTErLMBMO2XmxFB3fqOAN+ipGO86MigQjg3QSql504jKVy2QWX8B3PbUnw4Jv/WSHP1zl9uac/1YN3HAdnvzNcKMDArhleFmwiNEUM4JSQNCvOxx41reyvugJICKUOtiIduAmohqeRLysUSzgS0DqIpdfj+XfMjcNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNYTPImiGR/3eGEcm6/RrHaMXd7MpVInOgEwLDEJIvc=;
 b=xzZEhl7sJSGCnFvgkoieAvq+DAsxvbyE8DLYY6BzGoMWqxJqkFKPVIOFr9aPsQojnYxP+r+urZ95cpO96KpjsTChe87EWkRRIeMIQs0EpGE1b9zhrkrqFY8ZqUNLbzI453I1AHLvOW08qZ6kkxcGjQUa34XhJTbiL97NQuAv/Ng=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB6039.namprd04.prod.outlook.com (2603:10b6:a03:e8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:53:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 08:53:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 5/8] btrfs: track compressed bio errors as blk_status_t
Thread-Topic: [PATCH 5/8] btrfs: track compressed bio errors as blk_status_t
Thread-Index: AQHYHs/dmMipe7HsXUWoJT7c5SY0uA==
Date:   Wed, 16 Feb 2022 08:53:48 +0000
Message-ID: <PH0PR04MB7416CEDBD67123015B071A529B359@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <20a9dc5bd938c090a6bf0def0e46604c5a94fcab.1644532798.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d8665f1-94d3-4bff-214d-08d9f129d8d8
x-ms-traffictypediagnostic: BYAPR04MB6039:EE_
x-microsoft-antispam-prvs: <BYAPR04MB60394EE1625590EE066A6DCC9B359@BYAPR04MB6039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GDd7aAKb270EltPjnu7Hgy1qtmsxYgvkVeGjUiOfQFw1PcumHM6VJaMnUmJVAZ/tR8O4wn4gBX+ylwARZtoJ4HF8UxEDYjm9LplCZvh90Udb19EyNSkGY1kM09zVzafRx+v5OGUtlaaVxOZ+zqVg727yU+P8uZP8nYdHh71/ZaWcojhNiiamZaoowYlkVsvgTtn8WADl0eYe3T4JBPr8sCwbsqcbNDqCna86NgUjHOLAhC51iHsFPHGWfXpi526idy6eywA5Gd3yHnIH0RZVWzV51u8gBDx+yEt1ZOjYtvy7PBwEF3BmlmtCxWUXzlR9KFvE53S3gBm1jqhAz7zezNaObpbzeZiEEfvNrxLulj1KYYpd6Kn6GQC2fiHd6XzwEAiTu6gbcf77MsZNhB06GzMGMhYK7BjcI9zFKBcMgVe/yKWHUZyIyLneOg5nUwD2jBx6UgDDvZp4a6ZPX6nD+x+zAlNze3vWXc18GHQJqAfSRNZbNzfycxjTEWe7K55evJBWgw/tF/JfBwwNcBh2cusWnvZnP68P/r/zkqrQwW+dYi7cYEJG1lTs5s7tsqcB3vE29sgGsRNgzUhNWgpE+u++HSrRczW7oyPHSGu9y/wx3di20O814CqYar8zFmND/zDDh6wbKY8V8c7dEatwfNCnN+TDcCTxMKJMH/aBssxfCK5DK6djFd439d2G/tsaqpIQz2lIjtFxgFTFGRQ7Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(64756008)(6506007)(5660300002)(38070700005)(55016003)(2906002)(86362001)(66476007)(66946007)(76116006)(66556008)(66446008)(8936002)(8676002)(4744005)(38100700002)(122000001)(82960400001)(33656002)(52536014)(9686003)(71200400001)(508600001)(110136005)(316002)(53546011)(83380400001)(91956017)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tjvdDHG6lrzQ2wEWO7+2ukQ5wckVTh70gQ4fr2/kwljKnN9m10KkaWLMF8rI?=
 =?us-ascii?Q?ZcwJjgBdLl/mvdgTxD0dMT/PHLcWbMGYkG0Lg2LbWqsUVmPUqL8pCDLziyoo?=
 =?us-ascii?Q?YeOZfAm4SLCq3wzk2xVguyG8wqkxmG8QHYs5X7yW5xsb/hEkmKQ2Vqst7sge?=
 =?us-ascii?Q?tWb53xfuLlRXE7BduwgiftMDppZQMyo2+EQHuQ2c9d2CwI6btQmknr0pyOSh?=
 =?us-ascii?Q?Tr6P6hsQZ+6m8RJRjzj2eiuZvcP9ovLChKIcGFZPPSRe9u6EHZ9s4mLB0cl6?=
 =?us-ascii?Q?lDKW/VXO3F4xqXJoyS+9v2LgA8LK+SLn1Xq/2YwADYLn87MADul9qhWRnFHT?=
 =?us-ascii?Q?Ra1D+uxuBimb9T3mhdc+VZYP6IUpKVukqcPr2jIZi9b7DJlNoLwYbTN8bf+J?=
 =?us-ascii?Q?4kLYFNh5jZDMhmW+feQBAp6jk89hU2oo7RjbOSU4hY9sDQOSpsMq9w+WK1EQ?=
 =?us-ascii?Q?j4+DUh8I/YfA2JuIJuPcaYF2J+IiSjryy0vLi8F7VDgDSfP3mfyaT0kHQSdb?=
 =?us-ascii?Q?u9NvFX3ydHhgjmm2/bSS1gkdufOMteN7F319Ov/2ADeD8uOhfpsPfK1xnB6u?=
 =?us-ascii?Q?ffjMdYmgsiJiPmnK8Pc4d7b60epMQh76i4+JLzVBUmhn2hz5h7EarYlSHuDJ?=
 =?us-ascii?Q?cWuoKGKzs9c37tJ/BofaUvmfz0dOF1isdmmFNORanrP/YbDKT5GxB559iKHq?=
 =?us-ascii?Q?Ju2beQSESnF8RF0JS/Ukvxsf9Aaf9Wq9dGv7D3/JMxJSARHwo8H3K9Vp5RTf?=
 =?us-ascii?Q?gJ8Zst0hfzbz2xGRnyn7x7XbgDTQxeUZTEFTiRv2yX671HgbCErqIxNatX3m?=
 =?us-ascii?Q?gmYLphBE0IioLQ5PEIT37UetLY95tHuSId5HZX0NBAvVmjL5lNB0Fa1RL6cl?=
 =?us-ascii?Q?BKulMIksTPO0Py8z9qwzY+yrS0N5DndE5COhAgMu1JdsVE/ZXekCKKY0MmqT?=
 =?us-ascii?Q?sLtCffDEZxuj3GwfIGaQSzV9qKdTL+YD5gKy5l5zoughuZLCrjQDYK3F+RtJ?=
 =?us-ascii?Q?oYiJEjOyByxX6S+twkhf25NwVjNYXo0nsiAML9RqoL56MRGlKJvGnCKqAzqh?=
 =?us-ascii?Q?nfh7ef4vc/fmt65/iXwgaFbZKrYBxCwfyXNF5IMOBvNEIOZelJqgneZPSOEy?=
 =?us-ascii?Q?ZqvTt3BOp+tv9xqg8cNJOGpm1bVpVQgnc/EKlGoT749bznOdTeKKaY+d3doq?=
 =?us-ascii?Q?MfF/+rZTUXsMyVX13KoyHNQVIoWVvud/luEpmai57CYw8opDuxWHCXTxE415?=
 =?us-ascii?Q?v0i/avt9qLNehrhJbF/gehTrbplGQ5Hqpr/8q6qaQzhN8PPmoXLSjixOVNoO?=
 =?us-ascii?Q?APNcDqFj2NfO7prPBhfrnani668+O0GpgKOIfGwE0NdQkED9gQMuudCxduat?=
 =?us-ascii?Q?dz7l+yWfIVJtKF3r5TFLHNTKNtIhloUdAY6wlTTR3jbbdUqmx+mTXDZapNDS?=
 =?us-ascii?Q?MbrSekogCwBPpGd9449ZC2dhRcN5XjDaJQn+9IuEYv3FRrTSloR2he0+F2T3?=
 =?us-ascii?Q?vvSHWlf3KLnhB265yAavxYJkJRnTP8hU47B2N+uZE7zrUhvkV8/HEwEXORF+?=
 =?us-ascii?Q?VUdGpyjxxQeCQy4CiI7uZW6v5MzNIesrKCfauSEVT/BWh1ehBA3TcSCUJL9b?=
 =?us-ascii?Q?TZ0jk9/Sn8v/8n5wJPPdAwjSdJ4qNSyBlNM5ZfQ5mAwNG4aM2zabIT9hBOW7?=
 =?us-ascii?Q?kdRQzibQnagmNdHCWXfCp3K365DMiW870FwQ81GU5TN6W6M54fQvCSuX8oJF?=
 =?us-ascii?Q?rLE4Uc9FVKTziirrNbr7tNQxRwGor2o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8665f1-94d3-4bff-214d-08d9f129d8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:53:48.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbbYTgP49EpadEOr1FKMvMwpT0PjqWuOehULZLoKmozZgrWGGF15MW34cDuuHiZAUJ5YeYOrz2872X9o2Z/I4ElGAmZM2R05kG88gpV0tzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6039
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2022 23:45, Josef Bacik wrote:=0A=
> @@ -372,14 +374,14 @@ static void finish_compressed_bio_write(struct comp=
ressed_bio *cb)=0A=
>  {=0A=
>  	struct inode *inode =3D cb->inode;=0A=
>  	unsigned int index;=0A=
> +	int errno =3D blk_status_to_errno(cb->status);=0A=
>  =0A=
>  	/*=0A=
>  	 * Ok, we're the last bio for this extent, step one is to call back=0A=
>  	 * into the FS and do all the end_io operations.=0A=
>  	 */=0A=
>  	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,=0A=
> -			cb->start, cb->start + cb->len - 1,=0A=
> -			!cb->errors);=0A=
> +			cb->start, cb->start + cb->len - 1, errno =3D=3D 0);=0A=
=0A=
No need for the errno here, it could just be:=0A=
=0A=
	btrfs_writepage_endio_finish_ordered(BTRFS_I(inode), NULL,=0A=
			cb->start, cb->start + cb->len - 1,=0A=
			cb->status =3D=3D BLK_STS_OK);=0A=
