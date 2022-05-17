Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789FF52A5D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349778AbiEQPSU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiEQPSS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:18:18 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F06827FCF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652800697; x=1684336697;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=YarU3+LFZjzOEQ2cyKJolcVUCmns8K6RVWfLcMQ9MB6XAVf2rrxWp8F9
   DzwGYQkjOZcNKwHmQ8IHN5MnVCyfhMeWu0KQ3H36pWIt4wcQRrXQe7n+E
   Dcw3VSM3JFpxF+KMxjVXUKwwed0kDrtjbE3lKp5DDoD7Cwx0uvIxBvHg4
   nDxF+4/HQ9n5HRDgedFHO/C9gbPLIrY/J9TLk0zBghboW0XGxgrYLvIgk
   nt7ti+Ve7KTvRHCIydWRqHFwSDLy/Y2abHhLiA8Y9/Z6Vo03YIEtBxh69
   HMqxz44Pz18FPdOIJUt39Sv0MOPf8TpNToxDymA5/x6+ltJvlGhdXKodL
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="199388719"
Received: from mail-sn1anam02lp2046.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.46])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:18:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt8dc33ALfQQaeUjDPlDsIvFHmGtX4/1Rc7gv4Sol22AQRPlJjVE/4twYrs1ORqeH7Wl1pkVFhlyB4w/SybFRwT9lizN7N2gm4Khj0xCm/wXZ8ytQo4Ec51d6O4TeSbzds7oMKjtJGyJA82xJBgOfvCA1kPonzXJO1oFVyUR2BHr59TBkSmnbhBh37PyrNk7HaoJrNCfKgxtqYK/SzutL12x/IQYt4jeytWH9srX1/oHjDo0trSWJWncQQfEJKFxPq3y6p334H6FSdh6Ddq4WcoYlatFkbRgjiRWvAPAegdCtNWpLwfDOl1ep4LJpGjyfBV9AIQUqwudxnVjQ7Xc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RhV+ENCWriK4zOyvcBa4zsRFU/TPyyqTp6bymdozUgOG9VCJLIqzzJee+yYHAB7kOjUxYbVbIL9qRp6kCmpi2bLKIfa1W8EP031w75Tr7WZIDLNUq+pJs1ta+UMWCk+fjfoXO9Mvxx+ykDB6Q7ZNWjgx9N53AeZ9qKE0BMqU9lOFHW6z6SLw9z7A441kY0rWPoMq/7P6Onu5xZiVmbJvWtnoWm9j+Ui9lRklJ7/3rlHbx5CIpVKRdK3gYWakcDycdtNepgJoOJiTaLVPorYCZEZXB9msRql6lVSTXQ4TJH7pDkHyC9kjWCGT9/pvvp69a51gEXtA+8wJ+B6tpK1D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nv9DiFDw0wspJN9ktp+X5FyZpTGlFA/1eyRjjGi7oPQll/e9wZ1Z+iVtgl4+jL2UYky08C34tXNUXVw1OhIz3FrZQnu/L6lxIIgozgBoST53C38NY2BbUoctFstaNhR0Y5bjvWyLEEZcs13ztKjMJfdA/XVCzLZRMWN+G+Xm2HY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6191.namprd04.prod.outlook.com (2603:10b6:208:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Tue, 17 May
 2022 15:18:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:18:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/15] btrfs: factor out a helper to end a single sector
 from submit_data_read_repair
Thread-Topic: [PATCH 07/15] btrfs: factor out a helper to end a single sector
 from submit_data_read_repair
Thread-Index: AQHYaf2y38EOUcjRKkaw+X2c82FErw==
Date:   Tue, 17 May 2022 15:18:10 +0000
Message-ID: <PH0PR04MB74167E8AE0698424680FA2299BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c0fbacc3-44ad-4782-6112-08da3818743d
x-ms-traffictypediagnostic: MN2PR04MB6191:EE_
x-microsoft-antispam-prvs: <MN2PR04MB61916049BEE2F45B2DF942649BCE9@MN2PR04MB6191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTIV72xBOoIMdnI59uHh7RXMb7jEhpBB11Kfy7lIkmzNHFowgbGcjEQs1/8zyCNda64LnJLvMXvJSNGae8FtKXdW1RpIc0IApMc2Gn6sv9X9ElrYNS5FVisndsGdA7PucGA4lE/ZP4Fbn3y2yG6FLdeIFsJQunyhFc24sjZaG9bJxoBKHUqmXFFdYn7hz55uGRmQl1S8SaaQ87+i0+TkplHEItMOtIOPa/3nPEs49BjPJta+Vcr6C8XzN4u5gVqjsQyO2l86q0Ski0/xbku78uysbPMJaKyovzSYIiG3RkmVv60x3Zx+heW/KzzWQfMND0UK1DeMgKiqpZt7mjF1KWhd0MIMn08sMl1orKczbQ8I9ZxMuERVf/ioSIk7e31HIDu/fUHlDfu4HogEth4yxM8gNgXsRMCtYsP6W6vtV87e8RwuT5A4gFbXFepFwNP+qE3wousfZE6NPHAb0+gPETT8slhDZ28U4sflnZ8T2nUVG2l3fyi5RyiXBGD8dh0OPcx6H23EWRIkBDMi7dBzJtOarBNRwmtE6FgRwUZu9ixUhiJujo8eZg2qHc83iKP+/v1tAFlpdI7Y5eA94f/huylOYkrI0+IWO/m1GASssvN22pLRmLNojmUVFPjwjVkqkmL+NaC2Lym+mIkUnlYCojS/GG9+hijOu3Uq8PXx8LtdYoAmfeydYhI5CahGQpk7+nhrYw4ZqH2H5UCE2idN2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(122000001)(55016003)(52536014)(110136005)(2906002)(186003)(19618925003)(508600001)(38100700002)(38070700005)(86362001)(316002)(33656002)(71200400001)(91956017)(76116006)(66946007)(4326008)(8676002)(64756008)(4270600006)(66446008)(66476007)(66556008)(54906003)(7696005)(558084003)(6506007)(5660300002)(9686003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BC3qCzhm16qu80Co7KmZHWYOscWPkrbAZIZGvFFI1iuZfV4/SS2/xMIcofYb?=
 =?us-ascii?Q?ohw8aBLhcfcskA/Ly5/DSFmHLi0YEkOPgFUHt9wAr6w5xOQeBqmLhFjsorii?=
 =?us-ascii?Q?33k6U3Sn+bZHxzepQsqiL5DRDGa/ac5BCHe+9c+WRJ4Y68SmR7fzCZhA1YXy?=
 =?us-ascii?Q?T9qLKXnS3zRV+rv4ToHovCCqm/Y7k4tJko80bjgdq+yEicuA1iNbxxhzdDLX?=
 =?us-ascii?Q?Tum78IHod6bqlAki48hBE16fBZ+IKL82yzvHmH4tkfsvChekVC3WU5lCvdPu?=
 =?us-ascii?Q?GGbYI+z3PjxxN6siURs1nqc5k1xBHtuiGDASqNGiMsPkBaT/JBstnQJxpnWP?=
 =?us-ascii?Q?3OZez47664AAor2Vxmnarpz7h+C1NMchnMl+I9DXrg4vrjKltLvodnfE9LQD?=
 =?us-ascii?Q?A+52GzkRDmqsT3dyyvaRtt1NcFKmIjbZ++9QXeE8ASRSAgNm9UfJue82blLw?=
 =?us-ascii?Q?iSCpUmMjfFyf+LEzE640vpEntVV0mFWZzHOfVW0MPWWNdUMz8olre4S+S/ba?=
 =?us-ascii?Q?df/pjwHoQ447M8mle+/kzCuJ/99BlQu9oavuL6GT6Vf/fzqp/Zehps+w75a0?=
 =?us-ascii?Q?etnoymdFMLfbCxRy9emWwGibWhFAI8t0GOnCgONc1AYZLyS9UnmQ7dn3JAIR?=
 =?us-ascii?Q?XrSf0AIftoLXmvxZ3D2ADqm7MhPfQCSkfhf2RGyUm4fuTQHhxzb+0D5mn6F7?=
 =?us-ascii?Q?/+4Hy6NvSwcyngloC41bqN9rzUvHW/fk8NjeCVAI+DtW+DNS/lB4AXpxOhzy?=
 =?us-ascii?Q?8z3NnxNv0sZrdPMv5ALmJOg39oOd1s27a/KaOYB3VGvegndm9NU9cgQC17mM?=
 =?us-ascii?Q?nxK9OazDv4zWckb/+gSVBLz0a5KRcrEA+KRuBz5QzhUdC2DK01N3wQjHekns?=
 =?us-ascii?Q?T5PELDtDYXJeaC/8LluD6SgDTm7wAj3xqvofQn/IzrhqzKobBxi/Y8OwjgXn?=
 =?us-ascii?Q?cGoQYVb3IHaGlvWeAgubO3jxp9n6VwKNwRkBKghg+IGfPpd/n7lv9LF6zfRs?=
 =?us-ascii?Q?BCbv/Uy8aLxBzZGbCIi+rQbqrCJuy7CAnf97kvmhD9Qt1kqsdqWuw/JK2oFP?=
 =?us-ascii?Q?0Vo9Hwi1193BJ8kTRObK/OTtokc+tkBKPTLAzOKsCN4jNPCar6QUkR9aVZ3f?=
 =?us-ascii?Q?xux/zf4fSAw8L4wqL3wKvkGywCjBWdPqp+FRWY8w4I19hLNXPYxtZtFjeNnh?=
 =?us-ascii?Q?8ou3K1U1am1Wl9NC9hrN8K3rMnGOUOlkrD42WcDb6oog0MnvDV20IRbCKKrP?=
 =?us-ascii?Q?zBMHT9MMOjM6q8x8+7gWhjbMucTswkUAGLJ+JNvHEqjEF/cqEhCi5baXaF8x?=
 =?us-ascii?Q?KexcHPRAFnlNhW5fHkRoObnxzydbId6OHhj5fIoBv/hBk0xZvQ2fRFy3nNlj?=
 =?us-ascii?Q?h2cywU+4NOuG0yr6LdKlC4i9nrvCDJSfD+VGsBdFFjlMqcNEJao24d0P8u/h?=
 =?us-ascii?Q?C3VcVtuXD5142d0qWDDeA0XQHqbzkidV/r6/Z8Vjdi6WupFOznyoDLbQTvrb?=
 =?us-ascii?Q?smbiCBEjHU9RwMlMrsS0z0YiJZ558zKA0RlvUhYJ1jcWmSA7i56ERskDHWJ+?=
 =?us-ascii?Q?AGEHFXeaVGe7vZUUMyu4BoM1PU1CKPArl9LaUreNa6cVcY9rMhZe/arKPCqf?=
 =?us-ascii?Q?FUV/xCrPLx70T17j95DQ9iQPgEAHu+0s6zkG4uS3mlUtNSXUuR14hoQg0qve?=
 =?us-ascii?Q?h1a4w8vVET3ELfzsDbPXoxXD6g14QLruLFN0dczxV0eln4mus3cCNwPe3DvH?=
 =?us-ascii?Q?1JAxmJt2sa45bdZK5r6Wg8CtK2z3Y49b1I16qsWK+TQL539NJ/yEv+3vP7uK?=
x-ms-exchange-antispam-messagedata-1: 5olQ9Nhvq/aJizRhXn57cdO0naFkdg+WUL27hNpXOTQOEUFR8QH6Qezi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fbacc3-44ad-4782-6112-08da3818743d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:18:10.6271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5l+Q3UDu2+AoilFa6RbBVyoFUe70cuU9pfwJV3y13SpJUq86nosgLwt+d0l5Po6ZZVnVRtJlgqpX1lXD7yBSk9u49yRdhN1Hi9kDV6b3bI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6191
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
