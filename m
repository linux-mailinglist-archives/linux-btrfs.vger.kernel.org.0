Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFA529BA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 10:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242204AbiEQIBq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 04:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242521AbiEQIB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 04:01:26 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E821271
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 01:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652774484; x=1684310484;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+ji3/OT5L+FVmCekXMpUdr00FJvAW2+xYZUctud60uM=;
  b=pc6fneIugPy3txHWdMV8Y8HSBl/OgZ3bR66ttLiW0NeR3E9Jxtnh6hy8
   k0/HQMUf4GmoFLF6nU3GMBfuwoU1ZS9Q6meHJ8YhdEdNGuErWHG8C7Hag
   a1/2fbeGNBnpaC7BZijhLeB7CJ8tAIqs0Qnl4eCPeuBtzTlSTgbd7gSwP
   SMs0LMcAeVese4vNUdo1J4WW3sPuTuQjFr7J6bK45dNR5QcWskDfPR71i
   Vij+tsx2NponQRJwaL3uaIEW1RXMPgSty8DoUnlmqop4KlEM1LvoI/FNA
   56b2n+dxPlh2BUm0VmTCgqTORsT6MzNKrUi1iA3lU0SCWl/RUaOeqMsww
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="304751536"
Received: from mail-sn1anam02lp2042.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.42])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 16:01:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlxJpiQB796O34aqOmStViVJLOiQr3V21eZDxozvp44MZiZdnXX9twbkme4cJTyPhOST4ZleiBBqCfLCOREEaFPuy5gvFQ1VWWtGjqAAB7aji4rBUXPECec7GH2HBaflQCszn7xgVSEgQJBC4V5dv8U49ByqIiAlotPU4zSD8lavfWM65ci9wPtGn+UfizLsyqVoi3VZjrtVKWDjh44qgGj4XOXxtAr0RHXKjSUSpmC10+re0IhlTX9KQa3v2azoCIbvwxu+BNCLJs6V+K8ZH+hEcPXdRU9DNvP5+8ynusG7yg8PM/1xOCom9S+XgHoWw3yf/6vF5JcvHEFu0cQaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ji3/OT5L+FVmCekXMpUdr00FJvAW2+xYZUctud60uM=;
 b=HPwR+ZY7HYBjvUCzsT6C4OaiK3ZBH1727oF1CFZam+Z+UtnPn6V3YBz/AFdknxBkBAo/HezJ1AIFGVzzmbH/r/YygynJ7+stcDC1tguwzo5yKpLlxy4A+2ZX5T+4CoU4Tv9XaXGjvOb8OvVQsnPEepdhUpef3JfUY2TV6OyqehQmYzUiqzbau5Ds4jeLQkcfsU+LKIMzztKUaaL1U0Ecd+GeGpsGi5hTXBs4vdzFYGJSrXQ7KcHONy6dQUszEhrq2rG5iAzNOsobuFp8o/neJcf5gphwSstc0VNeE21zeO31iku/a4uuCpG/HBiNHX+r0H1xPHOlD/5+p0rrruU3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ji3/OT5L+FVmCekXMpUdr00FJvAW2+xYZUctud60uM=;
 b=pUjKRZmqENVdVm088WXrRPhsKAy6qgRDa+YIs+TNhN1sp5FBDNBw1u4S8+KgWpdZmrGl/VMBYT2FoubzqKqLO29/fC6oiR2+MizrF3DVTIgTmeoPxes0GSJjJmDhapQDPgq2wGtmjaZaDeOA5uGVG8mwyT5zPmytxd8Bsywxy68=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB1167.namprd04.prod.outlook.com (2603:10b6:300:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 08:01:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 08:01:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Thread-Topic: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Thread-Index: AQHYaTGympxAuoaYBU6nqqm7/wKLZg==
Date:   Tue, 17 May 2022 08:01:18 +0000
Message-ID: <PH0PR04MB7416E37722261F60A6B767AF9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
 <51ac74ff-ada4-a3ee-5638-2fad8fc14f03@gmx.com>
 <PH0PR04MB7416045672918E66690ADE8D9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <23307134-5651-281a-c6e3-359d3c846e4b@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f4cf02-f77f-41cb-d01d-08da37db6c52
x-ms-traffictypediagnostic: MWHPR04MB1167:EE_
x-microsoft-antispam-prvs: <MWHPR04MB1167832D0038DD834117A1269BCE9@MWHPR04MB1167.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bts8zjOTdtTlK58r2rwXOWiZkAdixMnoaQodM7zwwHx7kwb66fyqqAebOgB8NpgtNsdyWyHdYR7N8AWDYimgldQRDjDS8EOqwukF8gMasTZUhz/Cwg8osg7iWFOGD1Kq0UgS5JyqusmnXqZgFw9f+JvrvvkL1QOfCbuMnRxfogykR5sICnHKpyeUwbfIEYziZlRqebq++phaob4kNtTcbO9lqyJA0nh+yfneJpDECpSvDU6CNCsVxImMc2Kpl8PVYbwxC2T0+3yIqT8eZs0OFSh7GUNLj9aTeOeCs88p4LC6XOmBztG6FrbsqSEUD8F318MqjaZDaZTtg47oE9XlIxZspmpcXfPKhI8hOKBJNIKimTGwAtn0mKV88ETo44hEHynxQSjkEn7cjIgb9mJy+sbyv0ZcVI3bhxh7yOjRlKXb4gOkK6HgCAQHkrOKFw9c7jZVz9PbevcS8obZPcdRD0XaTXVi2F/0aRpZqkBHw0sguNOx9CgADIPPB2/I6TBx5CpZ/eIDaUk89meXobWAVU/FrE9HjtMY637/GDRmJw40z+1qFuAmZEo5BjrY/0WgsV8JwEYesbOsxN/nVah7hmqGallSV2qBvrZGthtNd0qHaxP9NqRehBB9cgZuIBboTbzWZ1n9nls2MKWCmp8GPii0muWYJFVlc9tct7cFclsbwaW8QcWEFPoX1Y5Z3yOv9HnBNZdDpTkxaUI1AUE8SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(53546011)(6506007)(8676002)(8936002)(86362001)(316002)(66476007)(66446008)(64756008)(9686003)(33656002)(71200400001)(508600001)(186003)(91956017)(52536014)(5660300002)(38070700005)(122000001)(2906002)(38100700002)(82960400001)(66556008)(66946007)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fqbtFpNZeash0ybdOgJhqWE1XuxcDPjgP5Mj2WK0WT6fJjyvyrvl+YMHLppu?=
 =?us-ascii?Q?HNdV6dzOO1dPr3qQl+uKR9qHbMi4ueEndDbtwh95u/sn38tnUiNuoZ+QZUPG?=
 =?us-ascii?Q?RBMBoNisnqewT5PySnGF+EB/Gqu34zp0L0Oi9fPr+B1o9ASkWy20DOZWp39z?=
 =?us-ascii?Q?/bUqh6JRCmRn4YkuLiFBoE7cN45AEy4yob66Vd6dSnq0EIn+Eoy5TM/kUCgO?=
 =?us-ascii?Q?/oS8rBPHU7V9pGIKur7DFacW0/Wabp/8cYx0XcJJUlzjD5eQYA7AHcVaACSM?=
 =?us-ascii?Q?ryRKbmROyhDa3TEEix9ze2xD0QjHfDGUyvw1bWAnG1p8J/F0ZeQBnA6lCtFS?=
 =?us-ascii?Q?poT5CKLGVuy7PehRAR8RV6w8I5ntkBL/jOal3x9bEScPyV12WNSlhQnnFieK?=
 =?us-ascii?Q?hje80gem6sejwPv6IZKKF9ZaPqLeJtNnrORYVvtAvXunz23+XDEbvD5kDIqh?=
 =?us-ascii?Q?79y3Rr6Dn29vtEwdjTRpwSi1UV7FMLcnYJm2ntdKmSElJxLaJPRfq6JbC40C?=
 =?us-ascii?Q?bonK5etE1WxO74HAilZBqoQpRyoBI2tLRu5d/sGEAZnwIHERr3GroN7bg3D8?=
 =?us-ascii?Q?69LeXjuRiycNlyhx5UkSRiQeAhUu6oOvmVFhUCZbPGduNGmkJFn6BKQAz+lJ?=
 =?us-ascii?Q?ASC5tOGM4xz85MCgcqj8vfD7i5l7OjxHK5DjMCokGIlTSFjeg5/vmQtpf/aP?=
 =?us-ascii?Q?E5qUr0VtJKG39bbQPLdpA8TkvXddL1sxga+w4fGy/BiLl70DhKtCI8cQaTlO?=
 =?us-ascii?Q?8eoRCUED6Xq6POEe+ZDSwm1/PwuXadwy8BRPJ7rT9jtJziOKvAv05yHHwsN1?=
 =?us-ascii?Q?nu5uq67H/mW9yZKxvjyRnREU4BICeve+ys3wHySTQ0KgmW773Tv2JHh1S11d?=
 =?us-ascii?Q?y0BWUUwXpFAsCUOepQB1jxN6OOeAdeYJsEyhw6zTbTBHprtReKeNIpzkTxhr?=
 =?us-ascii?Q?m2saT/JO8TG9CNy8LiqBg8IrJf9XydeOKaqSuspstoVbvHp6Nz2t1d/H/i/C?=
 =?us-ascii?Q?rOwLODxWE943kqMHbNoOkijY6oOn/Hhzx0WBjLjI7YbfLjC8EHJDcvuFAiro?=
 =?us-ascii?Q?AoDYcr444uDFIL1lGUH5rXB25FGDni7I8R0/GoosqI3gp/znDR5n++HofR3N?=
 =?us-ascii?Q?yJ10lmQOGs11cIYJfbTXf3NHuaRurbfAdV0BokgzcTl8JUfoUmc8kbgROTNN?=
 =?us-ascii?Q?Jej/Hh/wvDNa/P6B5CUK8Z+t4COL4UZbqLtSFu1+MqPfYHbLfvINXr9iICoi?=
 =?us-ascii?Q?IaE3tFgn/N1MNj0Vmmxh0Sf/Ex3PSGy5GoyarkioozRSpcAn2bq+HMb1ktXy?=
 =?us-ascii?Q?37raIO5/t+nC4YM47HpOi3Qzw33TWi/EbVkw2DSSGTro2R8iCSJMqr2sw9I8?=
 =?us-ascii?Q?sCXPLwLMViTDF1Y4AAZcCLBoQx7SF85Pk11ml1b6Oawwkrci41KGsvsP5+Ss?=
 =?us-ascii?Q?00I5xsTPLy1STD7JfOm6Qg8vvxNEc3nuy/n+n4klhKqKeyLyZozeKcUYPaT7?=
 =?us-ascii?Q?HdU1MQcctCwRZmKjlLkhVSHgl3p1+BxTc93Sc81iBx1g3SpZf6Zbb6X+Mujh?=
 =?us-ascii?Q?/F2f9oD0QACUO5kIsyAqhF79ZsR0S9SwvXnCKuE4YMWAmaJKD0+yvC4cib73?=
 =?us-ascii?Q?qelisXHM8NwUtfF4qi9F8yJ44VTkGXlrKxBJsd0L/Fh4HTS4O4Urqy2jKqHa?=
 =?us-ascii?Q?KcKxmDKUSl+pwgGTRm+kd4IEmLc+SIBKEN6bSx70y65u5aecEa1y0ZH6VkXe?=
 =?us-ascii?Q?CDveI5ti7tBXizMxARXoaKAwJezYazJqGZRSy6G/lr5+GtM5dPZKl3LBkkAv?=
x-ms-exchange-antispam-messagedata-1: jmNuXeZownxm0BnfTOiykDjn/W7w6clD+5gnpeAhltRYA7P+YlQlMv02
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f4cf02-f77f-41cb-d01d-08da37db6c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 08:01:18.0453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRwtho9Wotm4Gck39MQvqhoe6Av2vdY6puXy8bU3xtnD4VHhE3drsiY7Z/pMDN15H8sdkZ4fxej/9KXyomTOqtTY0dJrOaC8qvI1oMaLSTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1167
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 09:58, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/5/17 15:51, Johannes Thumshirn wrote:=0A=
>> On 17/05/2022 09:42, Qu Wenruo wrote:=0A=
>>>=0A=
>>> On 2022/5/16 22:31, Johannes Thumshirn wrote:=0A=
>>>> In preparation for upcoming changes, move 'struct btrfs_io_context' to=
=0A=
>>>> volumes.h, so we can use it outside of volumes.c=0A=
>>> In fact I don't think the naming itself (from myself) is that good.=0A=
>>>=0A=
>>> It maybe a good idea to also do a rename here.=0A=
>>>=0A=
>>> I have some bad alternatives, but doesn't seem better than the current=
=0A=
>>> generic naming either:=0A=
>>>=0A=
>>> - btrfs_io_mapping=0A=
>>> - btrfs_mapping_context=0A=
>>>=0A=
>>> Thus I guess the current name is chosen mostly due to lack of better on=
es.=0A=
>>=0A=
>> Yep but I'm not any better in naming *cough* btrfs_dp_stripe *cough*. Ma=
ybe=0A=
>> someone else has an idea.=0A=
> =0A=
> Forgot to ask in that thread, what does the "dp" naming mean?=0A=
=0A=
Declustered Parity, but that's misleading actually, as RAID1 doesn't do par=
ity=0A=
at all (although BTRFS RAID1 is a declustered RAID already).=0A=
=0A=
