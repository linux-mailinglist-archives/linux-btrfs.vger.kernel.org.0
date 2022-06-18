Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635F6550425
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jun 2022 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiFRLGL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Jun 2022 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiFRLGJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Jun 2022 07:06:09 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B09193E8
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Jun 2022 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655550367; x=1687086367;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PRN8cjdI3VWHfI476S/sh9oX/XRjeLgidyUMR7xO7fw=;
  b=oK4/wUY7frfUSygSXfHlgiNkM052xlq95zmNE9wyBsbq2kosLsg4GcIT
   llK5xwdF0UNz66KZUh2fhLSKuVLgXuF9xXKSL03HG7c9CDr1Pc0VyQuJF
   tpBWXBlgLWOHjfw1L1XrpUk/V6j/76aHtdPVCLDgnIehkR0jhExpObBZ4
   XB5cMLlLJMqMsA3x2bPAtanqP0ca99msJ7aYHJxE5wlknPQM2sMX2HT3X
   A7B34z+6RZ59a436EYoiVaXIrtJmKvRBv2AkA0E0q6TVe14BCnfDygGmT
   uOMWKaLYyURcwpD/0mdg5Cgp4YGWatN9sCeKPZgvllWakUxvP6u324NBS
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208368105"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2022 19:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp8zIq5+cFvzWwRX2WrOoCkTpGeDbm0KNPcGrUAYRV/iE5cRjI5KNrb5ZhK7HKbYBuyCsb+m6vQTJ0e/xFANJ57kbeXnDQZL/mObXYTb1UiXTiAz0PrtqvSJDfEb7RTHc6RtuGvb5iCZ460KDogaE6GFmC02sMcM5PXgaJjwZJw4o3VuVL7RCY3Eu8ymZklrhoewHfqoBI3CEY2KlV/LjJcOoQO/ngf+o3uTArhC89dpWMfebykueJW9CQ1DhZPHT3NzyEmMrkwAuOdOT4Xta5w1b2nbEjDcjER2RyWGZuy64RkHVnKirMyFmmvejmjrz8CJnOA2TaPnFi2eiwKA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoGI7JmJlq4+FMRygDD5C6b2bjt+Ykm1Zk9rbhV9nGc=;
 b=cXZurHhwgeN9UhS2mAsZ/19QI+HB6ZXXTsqmX8Yr6UnMctZkIRxUdkRVCzgnBmK1xrJ9NS2zWRHeUEueYaLvM263kB/fCcQkLCsLJqVxwfLOm05xjDSxnP8RY3Wf7UnvRQEcHm0CcpqN33dJtofcZnG9iuEvmX7wxgzatBTi+2h27VBns2DXeBQ6I7gGmW8J5ixhhxxfc8Ym8fGHwoan1sipCi7JRQgtDt7JmkcMh7YuI0NRZKrt2dG/x0HN9HaGj5LLOeDkb7sog885+CPpo4YHCkol70bfN0LXhHybaDgngojgbyhSbzjbdr4VjWtSddPa+GnoV8HHRXY5Rg5mXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoGI7JmJlq4+FMRygDD5C6b2bjt+Ykm1Zk9rbhV9nGc=;
 b=tX8O91w8RlW9gXZEP/7SEwDS+FK3ZN17+X5uQZcAZDcRwoOW7Pu7AcwPmHKyRCszc39flD2HNTvu/zrqsKI+rfm/WdrFev5LFzLM9Gxk7oaiZte1KK/yX5nCrte5SIop+6iBsUzK+44AxfSaR6B2bGoodLDwtby/nPA9j4SSyYQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6428.namprd04.prod.outlook.com (2603:10b6:5:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 11:06:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.018; Sat, 18 Jun 2022
 11:06:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 05/10] btrfs: remove the raid56_parity_recover return
 value
Thread-Topic: [PATCH 05/10] btrfs: remove the raid56_parity_recover return
 value
Thread-Index: AQHYgjGpw6vr7kJReUm8NjYTHPAq3g==
Date:   Sat, 18 Jun 2022 11:06:06 +0000
Message-ID: <PH0PR04MB74162BBB070D56528215E6569BAE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220617100414.1159680-1-hch@lst.de>
 <20220617100414.1159680-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae4f4c67-6a42-4ee5-b40c-08da511a8a9e
x-ms-traffictypediagnostic: DM6PR04MB6428:EE_
x-microsoft-antispam-prvs: <DM6PR04MB64280934CDD5F48533D28AF79BAE9@DM6PR04MB6428.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hooDdbtL1830kbAws+uC47IF+I0L6Ofl0GJjvIQPi3gz6kTBQkTGwkgvzWpXWcn+UJNVcqHgN6jgkjNR3sQd2a/VHJAyM+t4etuTYF7ZnCsoIwYq9TTyywTMRL79+mfxmP5qvbhMF59PRVDyEJ/Zkpr2mt3So7QsxxrLvQXT26JEQyQCS95cw2cTU50eukMsiYMUFhQO3zCc3M0wXez7Uf+/pxKz3YpyOoHFSw+xYy97PR5+jNXs1nOtkfeV6NOALiFIZ7ApNzcvsGabKvREPg0KAtqN0HvRyu/fX2+qJsoCC6SvhHKTdzCVb0xVTT31b77GvEhuitALm73WagtOv0idYwUUpG/wQTuRHkJLBzxZZ7wy5OCxzFY54gLdZ5eP/eylNIi5S86Dwe94+G875XokE9ZiXI9+nbVr+P3AagtP/8tRzqg+AxeW7SEEoh/EtqLkDjLpnIeFV63HdVlLvD/nCVO9G3SYN5Y9iRfHi5X1FQwG2moMKDC6aUDyuut+K+PEiyw5BpfuFb8xtxqU8yOFkD3cQj9EG5kpE0dvi4AuDzKHF5V45MJVGmZDUrkkRKRLovOaNNQY8qI9lyaFOqguWeWgFYjK9vaxCii5D2dXxr9Nhv3wPLvEN16JWDRYRKEUNlWWOspswfaKWs5WghSZeluC3kmxb9Sq3/ptJek0JuJCn7pQ16aJA9LnK0FaA/C5pk0NRMcv8NdX8ZRRAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(53546011)(186003)(55016003)(8936002)(6506007)(5660300002)(52536014)(7696005)(91956017)(4326008)(66446008)(8676002)(38100700002)(110136005)(316002)(64756008)(66946007)(66556008)(66476007)(76116006)(9686003)(71200400001)(82960400001)(26005)(2906002)(498600001)(122000001)(33656002)(38070700005)(558084003)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BneMF3NH4YkLs4V3hoe7NHGnicwh5DPE0Dbj07FNgf6/upI8QY+clhPriaVm?=
 =?us-ascii?Q?NCb6bKHoyUmeE+Kwx972n00uXFsmcszKa8AmLRJ6PChWN/L3TzaghhPqWz15?=
 =?us-ascii?Q?9TVXnPdKSnRr3TR5XQ44ty1k2m4ConD8CjqUG+fiiILJ2ELija7qd/i9e1Y3?=
 =?us-ascii?Q?n9ZLI2eQlg6XymPUOA72gRvi+Duz+laOPRSuNKfkiC1hCRgjpkqTtSQwozoS?=
 =?us-ascii?Q?qJ8a96BE9Wo3jO/nv1wHk2K2KlCRrK0qt8XsCFH48AwlB034+FjUVHt+awsj?=
 =?us-ascii?Q?/0s25JaO4RqjUtMyumgjUqDuTaR/sBWk96ld6xLws0C8RhMMIJi5B3g1uHpZ?=
 =?us-ascii?Q?XBwL1YhXaRj129R/kpxG9ypgHI3RAoHKD+ciwokisxY7Os6EOjTqKbQH003R?=
 =?us-ascii?Q?DFcOhcy8souXVb8MIk5JlYhAWB+HC2UCdEFBn9KxmwvyVKq8nbupfChmGaxU?=
 =?us-ascii?Q?0MfxsNSrYqh0AI8nwlvDPdAeu1Vo3fyiqOvigV7vWOAM7HjnEkfUmYVaLpBe?=
 =?us-ascii?Q?oZ5980gfg9s8c7NRQM0C+XINKQ3a/fwXxRXUSVNULW74lpAjphXAs3RAslnE?=
 =?us-ascii?Q?IF5TCLFqim1TlnJfNd21NlI71nZUNbLoNw19Fw2Pa17QJHhzyFTglv4Ii0JL?=
 =?us-ascii?Q?Lg44eyt5x/wm8sSPKoad90M84qnBcCHVZAI9o0vgrfLaLRKmsgYz2TVM5S57?=
 =?us-ascii?Q?oFAoGiOeEHllLhHaJ6r2kKDfKwILIWqY5Vbrr2WN2+7GFGIHEfgNVVQUpnku?=
 =?us-ascii?Q?270HyXBem2W1c2wfl2nftDlFMWgg0gvo+2U19oKlCoaD5d3TqOkLPhOPBHn7?=
 =?us-ascii?Q?BAL2zLyI6P/bUFqDdRSPOicaxv5hB+px8C7ZKIGrbSoZKr+FCeCWHGuIWnVN?=
 =?us-ascii?Q?nXzU/giuH2GsRcJhKnWsU4JI2s/69hnXfLGjV6MDCxnXoNP/Syl4QJVLiplc?=
 =?us-ascii?Q?sDH/yi8VeH99R9yyzjqibW1/v5DwckznYKwVy8fd2Nok3KhNobvly2kO4Zbc?=
 =?us-ascii?Q?abRdFmXyMM84AiLldqOK6D04AGqtk473+O2xnvZuYADYwTf9GPYSxTZFeT6L?=
 =?us-ascii?Q?MZ8veHy03+4y5rzyRfw7RH8GdGLFtggUzl3mUWbMTvPMp9HJzHAXugtGPPGP?=
 =?us-ascii?Q?2P9KRNXkwwW5gof+m4uVM4bK4xNug+ojLhHjAfwCRx1nRhCaO0dML+AvhMFN?=
 =?us-ascii?Q?9Cu0dW9ZK3LaOABWZ1eJWADHweCkUV8EhVQ5WVJCw1XBelMSsW9PTRrvFO3s?=
 =?us-ascii?Q?3JUt6dKAM7UEsi7cA9y5HDowzt0hoss/sZW2CKi+p7WFJC+r5Eo89VRPxkWL?=
 =?us-ascii?Q?q+C//T6v5SVrm8EO700rGqRt5/Wjgim9VY1MZWp8TD6wsEEGRpaDZbjHs2la?=
 =?us-ascii?Q?HuHtoHncd2Z5YUNlPo7nt+n7jANiw/MDnIvCNNfXYO9vpvRnOfC2U1xYifTh?=
 =?us-ascii?Q?rdMJF0WeIymJdmlG2s97+DqdvVoHjEbJg7e/uTHpxWLzhWaI7D6oyjB+HLGo?=
 =?us-ascii?Q?Qu1MfmXnuuoA/bOacEotUipJSC7p6Hs9TD63tFbhCaLpkPpYXCjKvpTpXL2J?=
 =?us-ascii?Q?J6vXEKxP7bUjghfo4SOM7vgmV3vLLwtnYL88XUtFB0rmc3zBlR00OYnF2W0H?=
 =?us-ascii?Q?vjE1WkDEjOqtcAe8TbfCqelCtTo0OMsB2U9SaGrKhCtitxoYV3alWn4C3vW3?=
 =?us-ascii?Q?dGrCZwD0D90ae/8KDeuhFGvaueRmUf5o5z7BRvoGZU7zgR2AO+8lmlFmLQa7?=
 =?us-ascii?Q?AyGrodYXxw3jSRvoBVUdI75Lue/RXaoB4qswEtgsPftX1yyuGZZ+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4f4c67-6a42-4ee5-b40c-08da511a8a9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2022 11:06:06.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSEY7T37fYLZFSeT9x90Xi1lChnCVkb1JL+0sEAUb9hlWSU2yRIy7PAuqwY0vJ82n01fbObuUPjXMjZUSZ0veQHEZpaBkNQX9vJz9MAJ/LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6428
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17.06.22 12:04, Christoph Hellwig wrote:=0A=
> -	ret =3D lock_stripe_add(rbio);=0A=
> +	if (lock_stripe_add(rbio))=0A=
> +		return;=0A=
>  =0A=
=0A=
I kinda have the feeling lock_stripe_add() should return bool,=0A=
but that's out of scope for this patch.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
