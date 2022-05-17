Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D76529BB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiEQIFI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242278AbiEQIFG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:05:06 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B187A3E5EB
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652774704; x=1684310704;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H6OFYOllAVloipqDGB1yqCsDZJn35auF6wv4Aj2x5a0=;
  b=ouqDFhm51XnPe7D+LddSDjPaB88+gTpp8qlfqJuU56EjwxoD1r1V1sO2
   gK/ubFE3FMaXShOAY7gP26U65eKP3pLHk8pcgJJK0NR1a2p7ne+ni9Sk/
   yvvbw0IuIyuSUCBKSZH3J+fvgba3nawYbPthDohpenwn73oInyJnMMruy
   sVMX+o63MmzDAwjTVifN3lZDYQ6lsY6b/1/8MhGlBv6rg89xDl+DFSHgO
   Gd73Xou4rAhxRMtn3+5r+BtLhsVyEnTbxtSxsSQxEh7NeF766YEIxLzke
   OgqrgVlxJ+z3gXwbnMKPoOYIGRTO5UpX6RxA1WjBdLoSDXo9EsjRF/EY0
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="312514092"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 16:05:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISukxo//+RwxgGREh8pA2SifCqbLiQGmkRJLL94hnMQLPWPMYVrFdl0UlhoNTsgjCRlwxPYHlg03L9e5UXWj8Oy1RKjyniyalLfPatLUXRi0hk1FbsKZVBqwnytiZpG2l48TOKqdL1HLGdP7JoNUkECz3vWJ1a95+9WboeTJeodbDqBZVtq7K3iOpuOEretOgM+D8QjQ06o1HA6KLR8OCucvHUerPz+21cwWbds2yFer84PWbNRMKE0M3yaSGnJMnmY/uuU1jX3RXhXgthynaDaKeNL3v3+UdfkWyyVcxi5haPWktEnXHhTzjwO4FhNBNzXJPG/eXU3qe9jeoQkO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fImIeT+JgAmEt3W+9WKRdNwV5xO/HY2HUqyMX5HCmU=;
 b=iDc8Z/pTGJUVW70fn9RME1O6GaMYSei3v/wHud1vrUxWSc09Fg6tYNhFWCtrfOwSEM8t5EaZNqdbrbckdDSq+wF+qsNCJQXwsKVv/695zEaB3dBBWV0w4h73cuQA5TAlDwqkLdY0YBPsKaoMcpSw8Vlp7ls30oChT8ADx+Y6k8NUn7nBsw6bT6kUQ7MesYNHQvxTXIeNZGkyTjUp5uuFxLVyXb6l25TpdOzyMJypr2Cri7toSEAChjHwus0OVzXS4FSTF1VqmzoW6IfXVRd8opuck9hKuESQZALHFR/snOWR1YIsdChDm6MwThTZC9wXXHnt7ZKG08J9fVUGQZwPsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fImIeT+JgAmEt3W+9WKRdNwV5xO/HY2HUqyMX5HCmU=;
 b=sqo+3uWOb8N+sIczwrCoCQ/lPxhAX8Kcfa2pFIIy/eklMe/OrQHAJlIGnDphS2M9b20m9qcqcuTVUv/kMGDzLUxZ2zmXC4TRvWspafJ7J0Ih2x7sBToglzwx91GsTOIK5bDBh65Fn9RWWQY0eDdWqKpzvZ8K59kx2YnR0rUVbYk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5498.namprd04.prod.outlook.com (2603:10b6:5:12c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 08:05:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:05:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
Thread-Topic: [RFC ONLY 4/8] btrfs: add boilerplate code to insert raid extent
Thread-Index: AQHYaTGy9m3OqPs/Bk25RY6IUL4lwA==
Date:   Tue, 17 May 2022 08:05:00 +0000
Message-ID: <PH0PR04MB741629BEB88E574566C653E99BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <35ea1d22a55d8dd30bc9f9dfcd4a48890bf7feaf.1652711187.git.johannes.thumshirn@wdc.com>
 <bc94b2bf-4c29-d436-be18-da4e64f0fc18@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65f81f6b-99ae-4532-439a-08da37dbf123
x-ms-traffictypediagnostic: DM6PR04MB5498:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5498E000CFE51379D616203F9BCE9@DM6PR04MB5498.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qvrLJjUoMzqywrixdIU2bRTZcqOCpdzWcGwn8k0QwLyLfYZmQaboHwUCTmYbequE4CTysfaV1sxIBVumlHT96Ug2rAr43ZThtOXLG7d/rq+zSxbqwHqzLkxdxC7CRE07Z3ixzjGWtAIi7k4ywK4gCUt+v+ihWi0APCR5e4yDjqloA6E2z7eqa8t4qjoaXTcHUoZg35gIdiSP5r1evTYfPC5WxWa+v+UROMEl9r+YGrO7mpT9pZoXeI7ONIC3CmUvTmgte4UpIRzxOMYqJG0hEIUzxM8ZQWncD1OiGwoUSZuHuufLXeraWPU5lD3X2FYO/bnjjQFivbckhuGX4cV/sgCXjy2LU+FoVdt1Ba+aOImDVLGaf33FqVjWLL0I2hBkwFQWBbKib4z6pLMVw09VefGryu5f/DuiqHLk+mZp9M5n903ULXz7AIwq5exiJMf+o840xj5N5heblVEt+Fyb4qqYjn341vt8rqiGNMMwGktNp8NVuWMAujeOunxZ5TejFc0MhV2PEVSjmAvDEmpMImsnR59JFetJ/eCpWt4qdX9yjKqnyoG2chawdTjJTIA3LjFv+Jv++NomYhewkAz9H9v+hOml1tMOii3gIhqMY/exbhzb7sGnnYl5KZCW+WWoBnt0SJc1Ji1HY2TDnlnp0ALBSloWjOFdHlTJKhICT7Uzm6an098PtF5ZMPzaF2QgmfS+XojllkYZdbNVL5hsKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(122000001)(9686003)(38100700002)(82960400001)(316002)(7696005)(110136005)(186003)(83380400001)(86362001)(71200400001)(91956017)(508600001)(5660300002)(52536014)(66556008)(8676002)(64756008)(66476007)(66946007)(76116006)(66446008)(4744005)(8936002)(55016003)(6506007)(53546011)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rR0ZFHxhwxxQhObqwGxnWXQ9BCz1BBj+cUn4jhAWNoI9r7aYTIEGVwPMYOf?=
 =?us-ascii?Q?CJzJ6mUVhDVUjzX6vlscgrY9ieH7vZ+TFkJf2CR5oZu/Dsq7GKJoBc1wTvOm?=
 =?us-ascii?Q?kLeo/cFxQuEfwbq6paM9d+5vLh8ywe8k2xKbnzYbkK9Jcapr7WF+nrT8m+c+?=
 =?us-ascii?Q?Lknf03PO90au3sUwyZwAwDCb4WIbq6FZcjxVs2mL+o8bvOO7opDQNzBshLEH?=
 =?us-ascii?Q?XDWH0NSLQWT88WkTpchgQr9x3wj5EuP5NEAgfVBxoh1z8W0Y0vaQck0YXDTs?=
 =?us-ascii?Q?C4EjJlqkXYzotG0EozVvjmhrCa40wnIoSyP/IgCUNFJK36slQyqkPYcAQjsW?=
 =?us-ascii?Q?fWPZ8BNvwsJNJ9vlxiHsiCy01kyTmL+NHvNZtaatwztrff0VqmAEazwQkjhh?=
 =?us-ascii?Q?2nkEL5SLhk2Uwjpn5AmJE0UQaZ95NPSSdphayVG52wi3UKAOBsLNsGfSIbIq?=
 =?us-ascii?Q?Q5IMkf4ZjFrQ9kKtJ3jYRjIkRr+DoFm6WQPf3q4+NVKXbwXrCu12upW1Iysz?=
 =?us-ascii?Q?aKBC4y9LcOOw71sJwJ6zJ8BUAEEjLqyGvY/gpsv9/qjVqo3U185VEDee0T7U?=
 =?us-ascii?Q?PmWfLL1C3E8IOeO18wijDGrTlyYZ2ASlDEA2OqKlkUF+LDIhQrGCh54H1KsS?=
 =?us-ascii?Q?+7I0Pd1+maMZzmw2gfuqLTjz7lOVdDVGDaGxY0jKCTQLUlIHvZnkEP8Ol4Yn?=
 =?us-ascii?Q?6PGDz6G76+9LKEPlSIkU+ovK6amQbzfJLCUESKKUpe+W8PXmvMlgHoGsJ4uN?=
 =?us-ascii?Q?yag8qHB0Cty8WrwwJf2ErMwSxLGrPyVloGdn3+DjG51zkij3csSgt9sSQiQs?=
 =?us-ascii?Q?KJQ2FvzzWomYaikEYxsIJNfqUH+dLeXiCcF758H1mL0tZKZK1ipavzUwzGII?=
 =?us-ascii?Q?uUzhkfpxyx/Y4X4BdMatJjLZzrpIpDW3SDfXDJnm2iJJ+DYHkWREcASu23jX?=
 =?us-ascii?Q?uNBz5VqSVHQCyIERPIzWvHNdEw9CmJo1e4ypvbgDIDggvE6yfVUaYq3igP2A?=
 =?us-ascii?Q?iuPHl7YSYJj79nkLDyCaBB/CGvL6YJ8Ea9qTDuPKgIrNqPAj9UxUQ3T4W4Yw?=
 =?us-ascii?Q?pRuOjCXgjfnYaiYMBGb7FIPBFTcipfnINtlqeoOMCpVRsPJylXEDDzFlokdx?=
 =?us-ascii?Q?Mc0jZZXcY4C536ah4/sAq6LbUNzrhYME+kBvrFCmOp8Upwn6YG9Q7AAnVcZl?=
 =?us-ascii?Q?clQ6KWJbW/ApxsHmTXL+6RRI1iVBiNsXDgYbUKFpKoe2QKPBL5to63CojdL8?=
 =?us-ascii?Q?x2LmQG9J00O6M1x2yu8xd8DJTBMmYJ/TjDN+evK6B5nqHZ5kicuSE4fPx4pL?=
 =?us-ascii?Q?OzjHudOtA1dV1mFu7XFBp+3OJqaVsEOC5L8nlBKzcrXd6smfaTXmY7tPjp3x?=
 =?us-ascii?Q?10c5KAhhgIPADBdRA/DlalokybeoImA/abm9Cv7E0xpKx5rXc0B1bA8V+FUo?=
 =?us-ascii?Q?gXbjbilHgR4OhB59+UGDl3kP86zNTUMz7pURUagUqD1gSi9wy+bNKUS4wCwX?=
 =?us-ascii?Q?096LkQf2hS/CKK5oFdNJKtsKOjpTe9cwRdA99WJ3Fe2DoV/HvoH5GCsHkUr9?=
 =?us-ascii?Q?4xVIEBgT6WIp7ChlRlaNYZ1h+VHnFt65+g65nKJp0oJ+oh37bSZ8N3ZXFQCu?=
 =?us-ascii?Q?XqKBUNKbXMwoLyARFald8wGgbIce9cOLUvXrgQ01QHaFjKD4XIYE09lXq1xQ?=
 =?us-ascii?Q?Fi4lwjy8HQdKAODNWPNBLL1jvGxFwoD72WePdKh47dvyaD4tbfOGYoOscHGj?=
 =?us-ascii?Q?TipkxPagTchX0gnYSI5ImEHJqec8M4/Rar/jYz01MFik1GvqbVpSXGnmw6ke?=
x-ms-exchange-antispam-messagedata-1: RG3nQTFBBEM1nUpXmlsbnavuK+afnwVGMeuVXjThg8laXZScrDvfOYd6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f81f6b-99ae-4532-439a-08da37dbf123
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:05:00.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gzhszWdEJDEZ84hJaZlErWQMc0jUiZDw7b19EgkugWB1ddudtLO01zoKEpkoCcSGcUKVAikT2eSLAc61vlzn1eHBRD2MoLvQo9zAoKDkoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5498
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 10:01, Qu Wenruo wrote:=0A=
>> @@ -6700,6 +6713,12 @@ static void btrfs_end_bio(struct bio *bio)=0A=
>>   			 * go over the max number of errors=0A=
>>   			 */=0A=
>>   			bio->bi_status =3D BLK_STS_OK;=0A=
>> +=0A=
>> +			if (btrfs_op(bio) =3D=3D BTRFS_MAP_WRITE &&=0A=
>> +			    btrfs_need_stripe_tree_update(bioc)) {=0A=
>> +				btrfs_get_bioc(bioc);=0A=
>> +				schedule_work(&bioc->stripe_update_work);=0A=
> Considering the stripe tree should be a 1:1 map for file extents, can't=
=0A=
> we do it in btrfs_finish_ordered_io()?=0A=
=0A=
Unfortunately not at the moment. I need the stripes[] array from=0A=
btrfs_io_context to record the per-disk physical locations. Another=0A=
possibility would be to lift this array into btrfs_ordered_extent,=0A=
then it can be done in btrfs_finish_ordered_io().=0A=
