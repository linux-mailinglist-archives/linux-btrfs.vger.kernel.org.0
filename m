Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4706FBBE5
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 02:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjEIASD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 20:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEIASC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 20:18:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D694344BD
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 17:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683591480; x=1715127480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=OHkppm8dFuuwNX+69nGeSXKFTGtiQs1dR8JhqAfkP4zqVkjNB9FWV3nd
   sIzFU7T8SVSwx4K8cNeUWf7AvxDmoRdFuyq83TAo4gau2tAHQkVJq/exd
   ltvL8Yh71yaTCkrWJkXAT0MrSeitrNIjWfYhzGC6r3qQHIX8Nqqc2r2Gr
   MoAgiBUwcD2/Jj6XFSTw19hIb+SnTd9BTpqpkWGCn2jwkCrLB5GkVYMWZ
   6ZrBU21wb2I5xcldc1vaYsbFxDTO/I0jVr8pTgBZNZTDAPiSYcB9W7dJP
   1WDfPW2hSnpPDBP90sdsehUUy6yv47Gvx1pXAqAIaGUMxW9WwzxkER0pk
   w==;
X-IronPort-AV: E=Sophos;i="5.99,259,1677513600"; 
   d="scan'208";a="235159079"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2023 08:18:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnKfHYEe6RuVtGxD9JhDlxZqzKckZ+ReCO8PStgfj5tN+su6Tv9VXLfJNyrBt6jtA0Nrudp2qcu8LXcLgswfo9308fpi2HwPSM/SqbdZ9Z3JKgyf8/zF3cTskI2e+wqhYZ5XFdH+sHo4PNOt9PyQet44ymBxMfuQ7kHvnG30aJph3puiMz/BdR3q1EOM7omx0pvheoKkNYzOLoaDs3Yo8XqS20BhaA+6WqNluopPkIODXe+sgmhhkl4AbRvh7545udHk7YAXMrvo4RWJo7uKVrO6CjRIN7EA28sUWNqLzC5cMMgs758kAA87Oed1IvFNW738BDt6EB/5spUPg5NYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=QVtP9xvx/PvNodKEr1IAoHoYbdJ6K3EaYpej8OGQxdJDJE/4qO32BJwF/t6xAdlVBcCwSIKP3lOQzt+pEb7rX55p6HgefqiOnRGldVRclG2nES3YqrF53dLnyLebaQZg4G7wpv+xCUinRZf5fnuGSDlXtD26kwTqBUfkssbmpkkBhNPtVuFOo6P/cMf7V2fUT5JeX8LtVhXuDSZVU/wgWywpJHFjyDQ6Cs3/9hYqtMhF2VkzrnM1T882hihDwnQIQPZg4DyefqHW8FVlRb1FQaJhfcRQtwONJ4Ym61RUo+SAuxLBtNBvA2WJwVR38mC1ce7DVY89kKVWnyybP2JOTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=N6gzWjAWqs46VcV5Z0xQg9cbprqro6RUyVgkbM+qpZVBaYH1/D9EWXMZGSOeDspDY1w3BJGkPcynRq6F675ULlo66wb3hJktPdOhJvekJZh4mzuYjEHO1osFfeOI8QBaV3fquW26zTgn5oDDuPm1siDOih5DERs3dHGcnMCi0bw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8093.namprd04.prod.outlook.com (2603:10b6:408:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 00:17:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 00:17:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 15/21] btrfs: factor out a can_finish_ordered_extent
 helper
Thread-Topic: [PATCH 15/21] btrfs: factor out a can_finish_ordered_extent
 helper
Thread-Index: AQHZgceF/5rLNXHHBku0pDX1b/JPnK9RE9qA
Date:   Tue, 9 May 2023 00:17:58 +0000
Message-ID: <b9438a5e-31fa-cd2b-c945-9cf0aa32388f@wdc.com>
References: <20230508160843.133013-1-hch@lst.de>
 <20230508160843.133013-16-hch@lst.de>
In-Reply-To: <20230508160843.133013-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8093:EE_
x-ms-office365-filtering-correlation-id: e54f86bc-64cf-42fd-70e5-08db5022d7c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeMhGfv4yDyfY7JyvmMcRg9XcfDfRQPjh+QL1WPFy+o89r6btChwuryI53FyFWL7zY2br7Rf1BbMq2veD+yFJ6yveUKMl2f3it9LH3hA/qWEAG/W033qj8zbNbRyzKXk40hCQZ/sUfbTfiKWbB0DCRk47r6PlD875GgLQm3KRNPu9dwYbC2JYmHC5hZMEzSvXvMVLvp+xwN1Zj/i29XSvNjfWV5wOvtCUfd6wWlcLG3wwtqer5Pz+IYf/IIRb8f+j+OfigxFjQj1MxGNthrjwI6bOVqXISUrMZxvWgCNiaKyh7ltAtqNNECdWYxJHSW911G4WwKHLLlPe+NHVqsqWej5uFKXirnrZkgUL+NOooPfhSfLfjfoRFCoPH0Bl4sFOfh+bPqhPDQxQLdMO5ROqVYBx2xIYeYYtQCJmy5A+V1YQ/2wsUjvc1hIq7KYPI96AnKqHPvY4V8IiM50PJLNX0kUxKMje667v53TJZB4plhkU4yAdLMvBF1QLyATw+glrLIbNkyNLaAAj9dCdjXHgyscQgY9B79h7sZrldGqLZibyUxHXTlNDRJq7yGnpFU46kKeq28KNSEf6ADFrOOjJoUEl5wr5qpbUfmqKq+GcuA/nIlFUAIhKu5W76GAz0eeujgsik3EjCYzn7QjfX5e85h2MWNKNAlsRxOQH3+uu7uUApG0X7nMp0AIB5ka0P+4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(31686004)(66556008)(66476007)(64756008)(478600001)(76116006)(4326008)(110136005)(6486002)(66946007)(91956017)(316002)(66446008)(86362001)(558084003)(36756003)(31696002)(26005)(6512007)(6506007)(2616005)(8936002)(41300700001)(2906002)(5660300002)(8676002)(19618925003)(82960400001)(38070700005)(186003)(4270600006)(38100700002)(122000001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3hkL1ErUWxRVlIvbkdVWUdFNHk5K1pqbFphdElkMUtrRkNSSmVtSFczT2NX?=
 =?utf-8?B?eEMxdHpKYS9YdG9MbEFXWkhmUVVvMHBUYXFHSGhNNUYvK1E3QSs0aXB1NER1?=
 =?utf-8?B?NmZsdGJSVzNZazNnemE3MFladnhaUHR4OFMzRkljTXh3MDlxNm9uOGNWQzZY?=
 =?utf-8?B?eTRjQXltRTRqTnc1Z3lTRVlSZ2dBOEZpK2xVQjBON3lMYkg3QndGOU81NXJr?=
 =?utf-8?B?anhrSkhyNHp0QWxORG50YUVtV0ZTQ3N3ZnBLRUhqTENjeWVTTFlJYUZqVlV6?=
 =?utf-8?B?RGNQVzFmcXpkdzQ3c0xCZEFzTkdYcjJ2d2YxVXNKNU5lemIrU3AxSXY0NzVj?=
 =?utf-8?B?MGNxNlJNRVlyTjFHem8rQitGU3hYem9hUnhnR1orRW9ySE1DWmloVDZZMFBS?=
 =?utf-8?B?T3hxU1BqcS9mbnpCZVowZ2dYZVJyUWJXa29ncUhLZ0ZnTXl5dUtKc1c0R2ZX?=
 =?utf-8?B?R0VsYVFsV1RZbVpJaHZLaGQ4bFhaRUR3ZzI3QXZIS3QyWTBtb1ZvN1pXOEVU?=
 =?utf-8?B?RzVhRE5nWjZoMnFPYW0yTU42ZXBFRU1WOWxhU2tlU2Q5L3pMV01DbElSZU1L?=
 =?utf-8?B?czNoWGJlWktHdVhGSGtNMFduZHNZcmZIZW9pMEtKYlljRWhENzFPNTU0VXVa?=
 =?utf-8?B?bVJlYTR2T3dQOXdoMzNTQlphbm4vZHBCY2ZqTTZKTDJUeStPOXFTL0xqVGh3?=
 =?utf-8?B?MWVGMkxuR3d6QlV3MyszalBrQzAxM3ZjYzZ6ZlFwZlhuVWVHNVF6RnloRlJ1?=
 =?utf-8?B?ZU1vV00zZUVHNU01ODV0eFpaNFFoYnF3TnYwdFgwWUZCa09XaFQ5aEh2czFz?=
 =?utf-8?B?WDNEUUR5MW5JdlI0TEwrTnZOR1NPTWlselN4REpWSkNQMHhuUVFPWHRrcFd5?=
 =?utf-8?B?T0RRVnJKais1SVlIWC9zSDlpRitXdmtNQW9Mck4yMzNXd0lEZ0loWHVTVVJS?=
 =?utf-8?B?TFgwYTcxU1g3VmoxTlRja0gvSUNZSlM0QndZWDdDT01ESUVJNmlXRXAvbWo4?=
 =?utf-8?B?SitiazMrTU9md2hQYmwxZHArTXVvVWRBcTNWNEJqWllsMjJHK3RMVG1DUWk3?=
 =?utf-8?B?Ymg0VCt6ckRIZ2w1ckduTmlvZm41UnZ5dW5hcUxNS3MrQVdNNktnRUc5NTV5?=
 =?utf-8?B?czVVZHJRY0tWR3R3ZlRnMXNORkE2NkIydjE3cGluaHdoWjVBTEhSVmZ2Zy9a?=
 =?utf-8?B?YzVpU2tvVm1PakxTUCs2bkl0ajZ6N0EyWFNoUUNpd2tCSWxmb3V1dFBrb1Rv?=
 =?utf-8?B?ZFRrdFQ0bDBlTkRpTE56TzhCdVlacDFQR2FudmZkL0pRdjE0WUxtZTMzMkt0?=
 =?utf-8?B?NXpaRFhtd0N5L0dyWnJRbzQ4STdocFk0WTdmU3lydmlzLzlHYXgzQTh6MEtk?=
 =?utf-8?B?R3VJUzZFeC92Z2Fjb1Bkc1RFNTJtUzlPUGxmVC9pM3dLWTJQeFNHWGMyakJR?=
 =?utf-8?B?eFdrL2VKaG5VenZYSUFuMXBHUEE4UkFIVDV1ODRpSldTSnBlQU1xVmsrYVJv?=
 =?utf-8?B?MVNsbkpxV0RXeTNSNFNkU0MzSTY5cGsrcm1RNzhqaE9tR215NGwwUFgrWmdO?=
 =?utf-8?B?UVM0Zk1nZTdhQVJ3bmhaT2Q1NFhycGhIamV6ZDZ2Mi8rNjh6QkZsSjFKeXhY?=
 =?utf-8?B?aWNST284YnNyRkJTd2prVlFSdVZhWVlGR0Z0MnUyc01xUzFSSzhmTk1OZmVh?=
 =?utf-8?B?dFJ3UWVWeUtmYlN2UytwUWI4ZEUzaDBySVZ6aTNtN3dXT3FIK1dXdmEzR2Vv?=
 =?utf-8?B?Nk9YaUxxNmdIaFF0LzVWYWhhNWEvN1pXM2N0T1diT1JJUjRIbmExM3VmVVA2?=
 =?utf-8?B?TWg1dGlBZGVDS3VoQS9vL3RTVGZrRFk3MWh6KzdWUllwZjkreUJvaWs5SXcx?=
 =?utf-8?B?UGJUVkpRN1pIcXI0Z2Z6bkJ0RHMvTjNwNFVOb3YvajlTSnZGVXlIM3ZwQlVj?=
 =?utf-8?B?eUNtenZCQ1BxTDl1aE9qRGtSQ2t6NVg5dmR2VGh1SFRMVGxpZUlzQ2JGbDlu?=
 =?utf-8?B?emtzTkJBaXhXZDN3WVhxamhsYisvcnpINHMzcGI3WGJqeHp5dm5qSzEwYnJi?=
 =?utf-8?B?dVRURkhNdTFzbzdZL1MxZFFiWDU5QkdRTFNNd0pLd3hUL2huMStFTDFHUDRP?=
 =?utf-8?B?djkvNGM1N25keDZJTG9lbWFKNjhTMmpCM21HV000d21hUzJOYWRXcURTWHRO?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <93838BF3036CF047BF00D2B6F7D351D5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: enYmQfm8/JK23JP9yl9bHAttDJ9aIsR9bgTLir8jBaeHeylNDADSBHjYghOPvGsHe83vv/Y+eYEw7N2gwqvLQ2HMLNnYGJSsSqHsqOuHzakbhTNbe28uB/PKgEaBdU4uR8igCG8vowFKjsWPwyP6clKFtLf+ILygXyWpa3kc9hs/ZnOA1ls+Gxy/o7BY+/M5Zk/2d3BHp35/nFsZdjAig+QkHcn1E0EFZrgq0bYci1DX9vuRtw9TjIGU39YCtl2SgKXFwa2e/vq+Jbm/4Amem5vXIQVOq7uHt+5AlUSh7oTMQZ9araVMdr1nLwJ21OiyAeUZW4pmXkhvnNzQgSJhZN/RoJ9B4gWqYRfywlqXNgLyaOsR0bpkQm8oYV3uLh7LsAFta3mlS18hyh1qhylrIQx3by001ZuYm/5AN3hb5kUfqEIaFMXDDBI64/OHfcHOeWAf0Oav6O2Euq8uiOjiQD+wQ0+P11EBNoxxO6vgJDdlATx/Ej7oGL3mrwxRTevWa1mwIeUA/bWPLpU1cFDWQTVwJIm0zKuXPoZrIZ8xmNiwaN8+Cken4XuZSwIK7DKC6jhySy5h4EKKg5+yaJ4j0Dxh3P6atIGddEVvnWjCKo3sL6WsDzmLu7ePTRLU1NvvZJGHeixR53Fm9KWto1rV/hOtXaw/CkI2jeyzKnDotwWUaUKqSCgy49ixNwFiEDIzRoFygE6roPa6P3rLhEYn44uPEMa59ElGDaFHYtJC3tIDrQpwMzgO9ycz2xUKR466QmnNVy+dTkePVCYh9yCe0bMFWDcaitFsIkZf/1vIofV5Ztf4lZCYLQRtt+NZcQYc3DVIRcKmuAkzmYV1GTMuxJ7p11c2Md7Cb0cr+MbtJai/2eWyzw88xBRoE1ycSHMA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e54f86bc-64cf-42fd-70e5-08db5022d7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 00:17:58.1519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppuzZ4FC3WWAGasGTiY3qaQuKo3mXpwdhrMMl8W76CJZ6iaorCqWs12hySe2CMASd+yUPuqi+cPF3zhMZxxRLvmHUL5W41uuZ6t2fC380oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8093
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
