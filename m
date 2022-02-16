Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898794B8351
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Feb 2022 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiBPItP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Feb 2022 03:49:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiBPItO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Feb 2022 03:49:14 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298792A8D01
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Feb 2022 00:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645001341; x=1676537341;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ls1zJvDu6WWRi1SieupgzlsmEpBpXuJPI1m2hWSr3lE=;
  b=qtHv2dNso2TtOxwtedF3wAoIbDAjn838xOpXlwGv+10G1AY2J/EOeDSL
   J2gq5Ik0ffU0nVnwl4MUG67gmqhidcDD4NatXSezUPb2Nr5tS3InAcwvF
   Dy7ye+d/R26HeZ/giBXhvQoEnq2elGoqmg5/MAVX5PdqZuzlef68bmcXT
   5MIjIrmHhKCVggiU099gepno8hg7IyeYwgQPyEi/RB0UQubEgX+d96FTB
   gweOxXIgxxP9oq4lvqQMX6bMzYVovrV5wLC/mdIUbmtjh7PcyjNXhTfbY
   b1LYYia0eRoRB6uXRVHcBrSpX7bdn+EW91tFqPlxrVSZ5yIEOQSfBtU9+
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="192013312"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 16:49:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdvaCINz70piRjO1NpneX41FX6TWuP2qt9oGa5I69PI55CZUwZ1mdVo+8L53OZRCo3sOe6XBEaw3K5X8QsfTdBBA1q7Scn7yHzK9F5yFmdOsUEACBZCO9ofRUksbNLqqo+dFAACGh1HvuzgXemjr/Ww0aZXCr8pSkutWK+t/U0wMBBnMc456kGPdFTFS7bDl+uW56nLtDxrLUCo/zzK2Cp/ntZEHaCbnjb57LppxKlSS+hO565SyRrZOLrsnaoCEgKBWKBEHZNovZ7OzWWiowH8rhYnvNg/kOQ21BfY4w+x+PMjaSgVBbAKBKbfUXjYkp8GaxBZ8o0OpNQQO3sdb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrQt7oSrKfe/KrtjBtJ/vNAhCLqEnT9NYprtO26bHW4=;
 b=MhwTjVSlA92st513UeVuQFqFXKoiywC4K7UNn4WtsjDds2uCE0ze/j50RvJpwuAEfcInxteYuHgN7OShRDQ1wyLSykfNu8Pc/fvFg1fxJ1U80OV+3DkVl6vWAjII3MlmbN+k8imJMd7u9M84S1KA8jx2hD6ORIyHB0FY8dKca7tpmqRqbXSSWDeyTXQdBYTSicpFtOgnMPRhfg1svFKr9dYmsUQD9YCWimlWfWrCqnndOXBhvn6QkOscxTyAVHLQZkjx2OCI3REGQOpncCcVUFU7J19VnvWclKm38TZEISGKsW8OidWyn067KZYMSyMIaAVc/PtjL/FyQSd9Hk1/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrQt7oSrKfe/KrtjBtJ/vNAhCLqEnT9NYprtO26bHW4=;
 b=Ch+qMbARed/1G0tjdWG0ObXcmYcurzffk5GdYX0t/dOkSkwIiRZgej0sofzmaF6YcIpuO8eB9unjg64Q/aJGD8Bg7/BBZMJUe2AUWt4OiiHuNJSl/1duUZ4hdkX9bMQe3afVFzqQV4MSWeuwfDAz/89uWUQ7l8Ay+ZuS7nv1Pig=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5530.namprd04.prod.outlook.com (2603:10b6:5:129::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 08:48:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8d9e:d733:bca6:bc0f%5]) with mapi id 15.20.4975.019; Wed, 16 Feb 2022
 08:49:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/8] btrfs: check correct bio in
 finish_compressed_bio_read
Thread-Topic: [PATCH 3/8] btrfs: check correct bio in
 finish_compressed_bio_read
Thread-Index: AQHYHs/dpYcgRuXHOUuyNKIJvTk89w==
Date:   Wed, 16 Feb 2022 08:48:59 +0000
Message-ID: <PH0PR04MB741628397FF6E1010B0453B79B359@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1644532798.git.josef@toxicpanda.com>
 <04d361b2ca1bdf0470e9fdbba00eecd801d18268.1644532798.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 990897c1-1307-4509-6f08-08d9f1292d04
x-ms-traffictypediagnostic: DM6PR04MB5530:EE_
x-microsoft-antispam-prvs: <DM6PR04MB55302163E7ED1E1C023320EC9B359@DM6PR04MB5530.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fr5WYAb0hSpR4JVqZMcxFAL7bQlL7BRdYMhT62zVEoHNY6vaDfpC5JDWiACBlQ8TrJLeoDTgkghDSyyZjwjqN25hn/kx8p7pkQSK3TzNkrBYKruESnoqlrjtJcSNBPXrPrfhclceHYE5JLPIHab9YB7cs4cNg05oqWR+MTH81PozEDBOpGpAU+jJchJs055N3xmCTwsrGwadPoAd2r/JiV0pV3kL0fMEWSYYOfMw9Dl0G3m0IYCDtqxTqWUOC/ceX2du3uxSTkQ7g5LY/DyqZXRhlBNApSFDwIvCQRN/kWWVWOo7OaZOZFYzwTTjv+pIj9+REn/Q4LflyF2feb3sGpyd/SeCHrZ7mgOwRPcuxcnBUeXC6phwLSYxhxXj8vuR7wsRBubVG5kkbAPKyEk+gTAPyZXK9sTBkFbvdTBRXUx3FzQ8MPGHOrvG5ULlvVNbWE9diD3+WkksBWFO7fIrFD8nlnX2mVSFNFIRdcNtokvVSrmNWnBUvrlMH0i55TTTEyZYPSsoOJBcrR9+g20Z/NzYxHUEodIzQ836Z9CA25nMGlG0R3Tg5OCnrg6KKcbafaO+aEnzowZflSrSuxSXkIM881zt+zEi96SUbx05F3EhL7xICHVypvKSSZRoJuSu3VlUADZb+bGpgLvBJTmD+0IURN3W0TGvDib9jZ3oo76DbWnMpobJgpALfIVeJNVK4w6lD5XmixeL6Zb8yA9Yog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(91956017)(9686003)(316002)(6506007)(508600001)(71200400001)(110136005)(7696005)(2906002)(52536014)(86362001)(76116006)(186003)(38100700002)(33656002)(55016003)(8936002)(66946007)(8676002)(66446008)(66556008)(122000001)(53546011)(82960400001)(64756008)(66476007)(5660300002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oF/t9HUFHymQWzfHa4byIXQ3Bd7lhdNs8HkZqjATV0s3i6Vcp2/MKzIruM5K?=
 =?us-ascii?Q?8zg6oSHm+EpFzQ/WbjOSKc1V1gd5nLQUsr7Ym+QAhzBXm7VzryIL/YuI+OaB?=
 =?us-ascii?Q?tNE4ZqdqTsVxJZqgBnOBu8l3TngB0mvQ9MxYMEHCZYt91khySaVGUpybaukW?=
 =?us-ascii?Q?dC9o/Igzla/vvemLWaOCBsHt0F2PnIY03bQS1/dHy40gIm35W3A6QdChxglc?=
 =?us-ascii?Q?4dDSy+hIi5jmBM8Ib3sbNiron2yQAWIFg37J7/Z0Pq7VB+b8+/Ub8/El6ng6?=
 =?us-ascii?Q?gFE+ElIZd7FjQMF7PTiQ+3VaXVaD+3N2qOf+8Uq7QMotoCesrVhjrVBPsblV?=
 =?us-ascii?Q?OR4B+XO6SYT139Ybu+tS9Y3DshfL7G7I1OlW2JezEoIV6qZN8plcXxLP/Gnw?=
 =?us-ascii?Q?C05nFZeR8Ir9XTu7vv0UKYw9e90ZMMDIK0P/kAXhH22FbyrPO2lbiGPOmpxe?=
 =?us-ascii?Q?1MdBmDmaVVPU5saxb0kKco4LA8KWTNmqFnSCN4fLpBGIfVmTkYo6wl3MzccZ?=
 =?us-ascii?Q?zE+rQg2M89R1n3DPpR+5iCWDjcMchAeLZH3/oMP10tgZvxyRn3oPg1H/EtdV?=
 =?us-ascii?Q?kRt8OxlOeVZT6WJ5clZ/eSl0BUiA4eyTQdTUhSoUpQe35qdhP/0e5t1Bgnyb?=
 =?us-ascii?Q?cpeiov9mNG1Boav8nX/sH9nvHRtXHiH3AvlFCbJeLxc/OzD7i2WT8DLG/IfX?=
 =?us-ascii?Q?LVZfV2uExYPbPgZSRbhjbrpcg0bNgDIEAfXCpGyp8lU2fIquGOt/ttGGF540?=
 =?us-ascii?Q?0DWD4Ua1Olfan//EJrxo9p/PTg6z2jNxTTKg/HSqFYcjYJ+FZT6l63vTfqM1?=
 =?us-ascii?Q?X6gknBDw6+YCXhe3X3wQoXWVgHmsRgc1RbuCmjiKbF+QOyrp/PZsIGHJpb26?=
 =?us-ascii?Q?pRGbW0cxo1zL8NQOVtciyfgg/IqFRFCrnbmM2BxE9JsQo186ZSW7s2gFc2Sq?=
 =?us-ascii?Q?FCmlHpuHryZSd0ROTr+DHN9cUSYVEH6gPRECX9kyg01b2UmoGbAUzNOneswy?=
 =?us-ascii?Q?hK3W2Yj9h0sTgh5p5VIx8D2rQpL2k09VPe0TwrpGNLuO7d9npH0LAuZQBGTa?=
 =?us-ascii?Q?GZo+WrM+f0CqtOtdCzw0/Ejjf82zqJHGuYz1kofofqSRcQjZAKDpWI5qtB50?=
 =?us-ascii?Q?wX0leAsxfkMOpL21nr9V/RvQqoNJMDZ/Rlm+vtugfxRkM4KJbXD3T9VUagnv?=
 =?us-ascii?Q?oSAQhkes97ZjUCeXd5orfzYZQoXmndl54KrYqzP+TmGeQTyJCCGMn83S9gOk?=
 =?us-ascii?Q?szduxTOW0Sdgfkm7RXxXew92QUAz8t0tYwV13KQEBpQlGAEVvgihi7F10h0n?=
 =?us-ascii?Q?6mL3XJgbdYSDii7SqgkS51yCJGQ6GWQ/jk2b+OzHuJatIlbNAKxlccxjYyzW?=
 =?us-ascii?Q?+LOngB1fQqfPV5I8rYN2epX6de4mbSDmf6q/r+dji7RVh1eiCLiajAyXvFL8?=
 =?us-ascii?Q?h0xB2tbGmdTSEu/yVciAOEbTRJOS+igkjf4FtE99HREIyKbt1ja+rxVXvFAd?=
 =?us-ascii?Q?MwVDvA3Eq6nDssM6X5VCUKEz9aeqK/0h61g9+l0rqJzojX7qQS/wXTibzGPl?=
 =?us-ascii?Q?uh08fzM7UOcnJhL6HS2NEb/D1CaNBMo1o9ynNgB2zGbCc0o/f4Y9oRSGVSi9?=
 =?us-ascii?Q?1RfRw6aJA6hLGHFQt44t/x9+DF4thnlZ0Ovh/VobpSlp0Uy6fEONX24QMEzX?=
 =?us-ascii?Q?CSgQZV8R55MA7j1ooH9fsHRMj4EEdhTttw3Otn2BLAHQmE5F92TuR8z10CzS?=
 =?us-ascii?Q?bDN3xPLdvbHDS7JLMRA8AzWe2GX/KFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990897c1-1307-4509-6f08-08d9f1292d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 08:48:59.9604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVMmtBsxbDh06sl1g8e83yxbLXAiyx7s87NsAkdhzQKEyPDRS4eAG6J2K2Xt5cYp/gD2gZVXgtmDq0Q4EhkRpewW2LfGeUoi7pWD9KOX5cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5530
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/02/2022 23:45, Josef Bacik wrote:=0A=
> Commit c09abff87f90 ("btrfs: cloned bios must not be iterated by=0A=
> bio_for_each_segment_all") added ASSERT()'s to make sure we weren't=0A=
> calling bio_for_each_segment_all() on a RAID5/6 bio.  However it was=0A=
> checking the bio that the compression code passed in, not the=0A=
> cb->orig_bio that we actually iterate over, so adjust this ASSERT() to=0A=
> check the correct bio.=0A=
> =0A=
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>=0A=
> ---=0A=
>  fs/btrfs/compression.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c=0A=
> index 71e5b2e9a1ba..a9d458305a08 100644=0A=
> --- a/fs/btrfs/compression.c=0A=
> +++ b/fs/btrfs/compression.c=0A=
> @@ -259,7 +259,7 @@ static void finish_compressed_bio_read(struct compres=
sed_bio *cb, struct bio *bi=0A=
>  		 * We have verified the checksum already, set page checked so=0A=
>  		 * the end_io handlers know about it=0A=
>  		 */=0A=
> -		ASSERT(!bio_flagged(bio, BIO_CLONED));=0A=
> +		ASSERT(!bio_flagged(cb->orig_bio, BIO_CLONED));=0A=
>  		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {=0A=
>  			u64 bvec_start =3D page_offset(bvec->bv_page) +=0A=
>  					 bvec->bv_offset;=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
