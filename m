Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28B25167C1
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354442AbiEAU3M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354399AbiEAU3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:29:10 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E353DA58
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436740; x=1682972740;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=UGVMNk6iU+4U6ltSgWU4/3Vbi4UfRECneyaZsGVMEHilQmaxWPRT4r6b
   dyAwBlXrhsnT5yQaOok+EshLk6uxFm62BkwBsgQi3XNhRAUKDpGG9bktU
   P4VXijyReOPA3yECYc3tQ4CN8rxYftBIhUfl+sGZwT8Irn6b4ExZ6qsQz
   lv3HqVJfDk5DxyFGwByTn07JGNtWi3sWk98S2nDFToAGkREjTzQvsMrHW
   C/Zo7H8mNUU90KtuleHrAaCprU/Pe+9NPR45lbtiDdmVlAr9mmq7ebFpy
   Cu2CA07oZx+JWX35kyqryMvsjtsHGxtC0bU4GTXA8bn3OTuEYJUTuDasD
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="199286998"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:25:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3DYav60ilWWCnP4gj5yLb9kOWowUfJDKTfapvNME9FjzvdfqkPhiJQp4GQRKK+SDyblIjXyTnZ0ENSe5a+28gUk/qE7QZO7djHNxIgCSOUj+KVzSwHwxf8dtfM1sN7aHje7Cv+FJ2HyEtVXVB62E2UOBaEGaA1OCbQJxvpGt38TQBooJrZqNKukMRPUpmuALFE0UlpSqcaOoGZ8EDxQmoQAdUtZNTUrYhGRF0+RgvNdqC21SmKDffTiDv9MICAGRRppcaguo7rwl9aCeSVz1g7IK9Um1xOc+LEcqBTKT0bbJ0zeWIppKJPV2eUNuAE90KB4vz0dMkm6y1GZrqwFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CRNWTKdYOkHfBXuElgf2SMvil697Ix4MzNwuJ6p6ZHK9Zi0UCmo8yaVgPI91JekQ5r96Rt6GNn+rWlwk5Na1vIxAnsLXHmeE0xogLwvTt0XVf15a6Fm97z4mdbl69/v55RsSEH/J71yTBws56EWBfpZnwruIM47WY5CgDT2pKRyndDjVLNbyPwjUdLc4rHpMxicCbEVGjonEjj8DqjlWbp38hYVdI88Zi+WPyBSwVCwe3QnX1RVgTCkaYi/Q/+1wPqNtSHlbPe7tdphkTFLk/0TFe9NQ+aXu4pa9OAlrXmMS0dYFohY/axpVw4lTc51aQ9Bp67gNxaKOLM3gzz7W0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Qb4Tq4izy9jxMmlb8fSqOQoLgslAd2hQJ3KunUzIpBlmVOiIOXeqUBt15zxQplguoDc8HIFpeqPpIXr5R6Tn4GLqglE28bFItU4TTZmWcMy60sN5gPvFIGwlXEwP3gGcuwVQGaMY9em3rrAfp+b9+OfEmJ2mwdDwj2A9gedfGYo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:25:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:25:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/9] btrfs: remove trivial helper update_nr_written
Thread-Topic: [PATCH 4/9] btrfs: remove trivial helper update_nr_written
Thread-Index: AQHYW/do/8q3efjkJECbHbsrZm5AKg==
Date:   Sun, 1 May 2022 20:25:41 +0000
Message-ID: <PH0PR04MB7416E6A7ED91BCA6FB434A179BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <fea480c17b89b32fe9ed21739d568750abe4674f.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70c9d6d7-ecdd-41ae-0be6-08da2bb0c2f7
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB66890119EB329D916D9E47FC9BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bgFFhI1L6gQSfT3jOpD3oWFuVC3ABFnfP1GEB9PmSkrFOhwGjJnheUq28DhUP4dcWh6CllpmDajcThkRn0K8vd0z/Nw1ys0ZkxaY5rDGBsVYibA/W1A82ZSDGfgkXzXBrMAsRRTR4PrEUBVp9QM0QFtVyOQfLH4nCaEJjS8MkOtiEM3A0OR3BJISNq/Gthjk36N8oklR+FGgeI7kZNd6VVMacHXjy07ZISNTCtI54cMDk43itCoe+kXmmekL8aBCi4DLM/YMiojodOsrKZIlPDlDoIdnNWf3f36RJutasZBf+l6vrlNt2rPWfL4XjO7IysFyA6eZljrSKaq9WRr9FPVdn2VT2rYivWuCsRXh81MBhGYI6hsvmoAFaFTnKXofy+YiFy0XlxEwTfgni3Y+yTVfZ4sETYWp/HRAVpHF6S+tlz3tLdijY1xCRCXu+zS8TwRvZGvsIsRti5lLb+5jqtm3WfKURKrXQmztm3fdoFg6IV1p1LFzYXjs0NYSPhv2xo0KGUvZJavTa2F/pRqSo/xhH0cu8lilfKILBc7o4FqxKXwDb1TzDwoqJetH8WbUxqkIKyYRtBAgsPhBocpTPYdkQL5CTM4DCyLL2OKs1JAXeFNLQI7svXkn20XftoArxKI2IGihrESU0o1L58186Qa3SnMUZn6D9H7jMW6luRduN4HDzkzZ8rCIcEb38TCVHE9HHi92EOwFG43d7BfnRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D8ymm4easrQWQtpgWMSLgxVozfDQlkkfyydokV84V/sGWGYCy0cZt6Wk7pgp?=
 =?us-ascii?Q?Rzvf7ex68de6lNK9bmNSmVmoNmnhLsV0GoQmpiPM80yK4FKpokPR4MRxfT3g?=
 =?us-ascii?Q?irbFVWnYjyEMv1eEGFuYNv8D4jKLsQpvlaA/R2xSnBD/uguUtCXnuqTb4LBf?=
 =?us-ascii?Q?lKmvmyE9Zr8ff3KdU8Iy18gUcUnA2GPCS6HoxNy2cgS7997sv1jSPtAMwAqp?=
 =?us-ascii?Q?HuftdpJYPrv2+AfT15mNO5Scy6/nBEU1I++ESnuNcnRrgh3lYnZBHmySLqZp?=
 =?us-ascii?Q?ctcXmqYIUclHVnn0wRTtlhTrzn8VVRHaTWXufuw3be2PTReWZjkYQXpvJC1x?=
 =?us-ascii?Q?awTZIg9oFhRQEfoWG8sxXv3/c2eZJ6YvFpAh8mx41KSnUJi5O9FtodNPmyJ4?=
 =?us-ascii?Q?yfkRjxuVLw0aNYj/jKo6nSyaRezQTghLFseW7xQxvibyCNDE4MZVWPies9Kc?=
 =?us-ascii?Q?ra0lWzIfS9ejPM1eBMQD77d15473byPjGmfS1Irl99lc+4n2M6Qa1LsEIlCe?=
 =?us-ascii?Q?0yWoid7UjuvMH5CTxyrKjClMmCjTzPzRvNTEK1CjbefCsY0M5W0qVWA9k8mO?=
 =?us-ascii?Q?NTz/M101NDRhxGB9Crucq6hiKAocObPM8eQu9AQDv1C0ktn8E/cNL8MmGb1h?=
 =?us-ascii?Q?8+pqt7RnSehfxW7QkZMG0jNY6gP36oEOTS9tPuCzYhJV8mD0AkhzZtW+w+sS?=
 =?us-ascii?Q?wnCkqlK5NtFFYTTC9qX8/iaiw7wl6DqOhpQWbJQkPxWpMEZzMt3KRP9/NGNl?=
 =?us-ascii?Q?R+lPQFpukB2I6cYwPv16oR+MVLmNbnDQbEaY/aIr8k17zxCjLqfk5+TWhLUO?=
 =?us-ascii?Q?tqxH08RZePItDkBZHz1xH+W0ja9woayogI8bkL5rfEl35g+murVMJByJ7pgG?=
 =?us-ascii?Q?lHJDhhGKn6+RnQjyepXJHW7pfHFyTXxLyv7lz91vcToGEMnGh4caEPfavXp8?=
 =?us-ascii?Q?7V8oyEHIZpjxSgXi7I3ZLw+v0U+KEvBT+nPU9Bbn2MHZ7DYU1069RnUhYNGy?=
 =?us-ascii?Q?h/d7ehfG7V3FI0EhEQDCKuh7OoGt6gpj+l1PupY+ePQTjOuuKWmgRgIMxXzl?=
 =?us-ascii?Q?PfAr6TPYuW5uog3CRPVaRSkGtB2sq6IN0k1o/ZpX8oKqpsuYfPuXGL6Wwxpv?=
 =?us-ascii?Q?ZJADDJxPiHcuTDqFeDTTsfchmKWWNvt/LJsrUud5r8cvd90xjrT3YKc0c796?=
 =?us-ascii?Q?V6HfUfbNBTPUiN36nE5Eq+oykRLseFZxjOU8VnX7jWQ4XtkEogT1X0jBSt9N?=
 =?us-ascii?Q?dEyZEY4pv5JegPzD0TXPkIvJb5CHiw5lGs+S5yvcSKSagJugPLe2VckewANo?=
 =?us-ascii?Q?v4Hvmg2SA1o6wOPwDT//njssvBGaWjlVQWY50fyjlZgaMDhqT4SXdk5KFhhl?=
 =?us-ascii?Q?ns4cscUF+OqyLCduegR0u6M2GmzGn0Z2D8mc3Axw+RUrYBx83QZB6vLzRE3U?=
 =?us-ascii?Q?r7JTPyiB6yCV6G0bWok3N5ajiErH/06HmvBckB9eFHFdC9juiLRks8Xmvaoj?=
 =?us-ascii?Q?p6rLDsw6D3WcGpqje64zXMhWZijGqjdtpYwLSktX8AyQ0Uol1GFZAyoaN06M?=
 =?us-ascii?Q?UedwOXzRkz0PsQ5nNlxA8+rh31fqYgczgBdp3znVAlS+QbWZKHoWedFXtvo7?=
 =?us-ascii?Q?q5FnOirUfV8Itt7OM7oJnna50nd6yOaxt5nlZ+DqfQH/jsJg9S9Pdo4pLEhY?=
 =?us-ascii?Q?3PbE5rwnITmbqLEFpI/Wk/P3nPfExhyTX2dzXVAf7owvh/ug7R3vtd5YV4Hi?=
 =?us-ascii?Q?86+ks419biQ0rNZDwjOR+xplv+JsHhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c9d6d7-ecdd-41ae-0be6-08da2bb0c2f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:25:41.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2mVNZR+qQHeM2Q/FNqA0wr3zByTV/YpyUftnfh2IFFZ2BemKxlBABkLzLm45Bx9LSd6IkM4sjv2BGHdP5RoRRdGL7tZzQXSLqKZZDlsiOUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
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
