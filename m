Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE026946B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 14:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBMNNF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 08:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBMNNE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 08:13:04 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D01ADCE
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 05:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676293962; x=1707829962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kuPBqfXbUnp3KW0Si7M+euBbNF5cMCLXD73rJDRStWI=;
  b=TuD1dg0VKvWPG0LZqAu6naorkA4Xwa1b5UMSXMCbYwJosAx6tBA/AnLk
   /3OJsOap3IrvLKpO9o60NJ8uCZnsYJZcXtTUH6RD4hKKJvCVe2ePkrloy
   OhEPaxWBPN73dKrVcmgXePviTUkRtPuG3u8xFzkYSilBaFI1Wnglw+gZU
   +5lyCckqGD2iY8/3yBHSDs4sGPHhXylf+1jQaWMGdsBSF1Rays7Gn7ehy
   /tgQUBj5WoJU3d4W7VOtD0sUEZOQqeSztwGQrhPj8QhsuF1WHcAMRKGwi
   bJez4AMr5WePxqa0S8upcTzNOE4qQWRMCPBXt0Uxd3NbBJIFE2Ow3ahsm
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="327479064"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2023 21:12:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDzyAzy+NrKMh5KTm1+C/Q9jXDfX/Kn9Fgzc234PVC/QIK42DHS2Icky1J9wdiKFQ10v6HCCmU8594L81gb0T6tunmDoVaGYqjWxB51t/fCJJqAi95xjSy3Uh3cGCS9SWyPD0+B9Dftkkf2CIq3X3wthyozMj0rRQAbPh09aV4LEo8br9Ot9CGJ6H8hIFfyKZhii4gqmaKnz44VhV5HM9+kYYWqXpeUQjWytmbZvzft3V+y3MTq4wSKRbrCzXi4IRNIFuWeIVSbUilE8woIT2qNzIAKY8jrP8mgEKHVyvCwY60kZfOh8XnEppXXHf0zwmjAfjxyU7jddMQggv22jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuPBqfXbUnp3KW0Si7M+euBbNF5cMCLXD73rJDRStWI=;
 b=ZtGcgl1531bmxwcNrXyyf54hOaWTU060YDXb/5HA8YfZD2TYcaiVuKMz/LlR2ObedTgA07yCOi2JcaHFg1DeS2bK7vtfLabzME5D/dXdRB010d/EjQw45s6gEYUWEgkV7yXevJO+mNtcUplCBDnIvDVaEmevyV2pdpsXyUkXkyw3wDOxGM9JGAQ+mlu1E1MWufxrMn6Hnr1mHhflb6rJ+21XflZSCa9OzJqkH7n3ZuD50iUn8ArL6jJrjaTAVG4alIbRSXvcJJM5BO5pv7LciuGvJgd8A0nURTbvTWhmIxN1K2KDhQHwoAkMSUntq9WzaGr7T6YgjOd4UjrBowbncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuPBqfXbUnp3KW0Si7M+euBbNF5cMCLXD73rJDRStWI=;
 b=PwAwte6g4MZlFWJOQA4qi01ZVVmcJXEhx5ufkv8wLU0w4IA/+9smoflKcVtr/3F8Ipv3H3zeu5/Ci++rp9Lv9cpwcYEMbY7NOxv8eXWhE3JX7Y7PVq4wUE3C+nSwofjw6IG4w3exYnC8T1dcxi+cHw4wMIAc5u/xo0hTJvMNcjs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8104.namprd04.prod.outlook.com (2603:10b6:8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Mon, 13 Feb 2023 13:12:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 13:12:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v5 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZO6w3+DMLZggJn0KZylohlYh4hq7MeXSAgAA/LwCAACm1AA==
Date:   Mon, 13 Feb 2023 13:12:38 +0000
Message-ID: <a3536b24-9c90-ea0f-b6b3-b90bc8073c91@wdc.com>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <96f86c817184925f3d1e625d735058373d90e757.1675853489.git.johannes.thumshirn@wdc.com>
 <Y+nfSQ6fxhDooglb@infradead.org>
 <7a0bba23-3f01-764b-a1b4-b88640b02b3c@wdc.com>
In-Reply-To: <7a0bba23-3f01-764b-a1b4-b88640b02b3c@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8104:EE_
x-ms-office365-filtering-correlation-id: 508c8f2e-aa20-44d3-1e6f-08db0dc3fb35
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJ89P5iyabY8mIrdB+Y9GMnK12/ti9vEAL/t1SUjk5KnFIj/iyg95qUjKtbcPJtiyHk6tHY4JTaByBOKp6fgQ9qKsE4T6U0eZ10h/gOisrFgMq4KXiMokJLtOtU363fQhdjzsQruz38FMa7u4e9Vi4B7LUF64Ghh0tdlK2ZEDIGzTzFrzI2u8U6CkIdPFJ7JVrdAFYM5PPurmiIguwK8lyhY2nbT1JWyTYO4AzZ0P+r7m+BBnr0B4oTZfzCwQPODOXQ0uFRj7H5Ovq2VJk2FRYqxgzXxwMeiOKg00lgcN2AsatV/Aj2PV/zK9LZn6S2qoyTG2DS3BZ6/yqAmR3jyrBqFBITSdU9y2naSnmLt9c+mBr/4jyEYDwWwSQok4fstbJBHkhOwdJJm7K1M1eXWUOgaRFD3deeFnjJWD/NUsGJDDWk3pECRJPMj870GhkiB3fZp/Df8ikd7Dd4nSWUR79twDunMy03m3Sagxo37VtxM/T8ECfs1kQW6s8deGp9j6z1Od41NJ6FcOELM/1LMAmnAhO07myAIGEDqc7xsCwI4u8D2uRJFNIOZJgP0lIXEDBhIQWFIqrskyhBuYUSjYlsHdJzGmuQksbKsjC012IXjbYWhANdwyDHKcCcRiBg8xpOc31aTqPeDdouTYjSqCyIYNpORrsZ2a/6Y1XNIPBpMHM/TLC8C6ZmsTqHf3lyx23yFO+UjELj1mxSqyoThcsjnpRaCuBoNq6qbEb0MlA8D3Ridoks8tBg/sRdz8IwKwGPQZZMkUPnig9D5b82wqDWHXdFkxedegEe/GpA+AsFzXSljK9IbapUt75QvFN8u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(83380400001)(66946007)(76116006)(91956017)(316002)(66476007)(66446008)(64756008)(5660300002)(8936002)(66556008)(4326008)(6916009)(8676002)(41300700001)(2616005)(478600001)(6506007)(53546011)(6512007)(186003)(6486002)(71200400001)(38070700005)(36756003)(31696002)(86362001)(2906002)(4744005)(82960400001)(38100700002)(122000001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmMwdCs5UUF2NkJJQWVrMEFxKzZWZXFqTEx1MFl4V1cvRm9NTmxaMnliRUx4?=
 =?utf-8?B?UVMzSDJTUWc3MmV1VG5mdFRzNUVrNERVNHU0Uk9SajhSWGpKY3RZb1Mwa0VZ?=
 =?utf-8?B?MjgvRGlNTkc3Z1kwUmpPcHRQajJzTWh2SmxLSjNpZlE0TXdkZFA0SC83RDVZ?=
 =?utf-8?B?Mjk2UHJNQVUydUhiMnVIRmlCOHk0OTdjRFpvdHYzR0NwTUNiQUtXMGpUUEFl?=
 =?utf-8?B?T2M2S2xJSGRlbk1DRzhHeDBsRVRJTHR2VElNbXY5UVg2aXNGSVpKYWFJYTV6?=
 =?utf-8?B?OEpYdXVVWDNjMDk1TWUwZ1VYMmE4NlptaGFlVkQyVjk4aEZsbmZ3QzJLdTJv?=
 =?utf-8?B?a2pQNkE3U1ZSMWVUa1lhdVFPcUtqZktMVkF0YjBXaTRUeWljZW9XU2YwRG0y?=
 =?utf-8?B?NFA3R0lvcnE4cW0zVkZBenk3ck95bjBlcFZ2aFdLaU1zWUZXN2twYm1iVk5u?=
 =?utf-8?B?eEZ1c2c3QjBJSXo0bTVsaXNmbzJsT1RFQmJHVjRKUExwRjVvMHJzRGlVeFRw?=
 =?utf-8?B?T2FxRkpBM1Vvd0hJdmpKSTZwaHFRZWRFaGxnOUU4dkliMFJJRGZrTllNbUZE?=
 =?utf-8?B?UjFvOVdDb0lFTHl1QWxDYzZSNDlocHh4SVNmNjdMU2crcVdGa3p4dWJLdkpi?=
 =?utf-8?B?MDQyallmVzNtSmx5VTRTN29mQjFmZDVWcVJLbXhPVUwrSktodzhhVk5rSmFT?=
 =?utf-8?B?TUwrSUYwWnNuVmRlVEV4M1RHYk54WElQYjlyazFUTVU5VDBlbzNnMWF5a1cy?=
 =?utf-8?B?WGRmSnE0c05GTGtialFVL0hiOXUxalhXdThob3FiZzJmeGIzTW5YRWIzcEtr?=
 =?utf-8?B?YjNwVlhkL1cyblJSU2txZkhFZmJ1Y2ZxOWR6Zk9UdWFNQkh5SWh0QnhSbmky?=
 =?utf-8?B?Y1hId1lzQXp4Tk5Ma3dkemxVRXNqb0I1b25GTGREYndjOENsdEZJVHlmT1hL?=
 =?utf-8?B?djR6M096aVNYT0E3eE8xSmw4M2Eyd1huc3htNlZRQzdXdnpqTm5kRUNPbWVO?=
 =?utf-8?B?ME1KaFRDMmkwUHE4OUxNUWJ2NTNqeU14b3J6bWl4RmZBeVkyelVzeGtWS2pE?=
 =?utf-8?B?b0VpK3VQZUhpcTZJMkhBRm9HNnJGa1ExQzh3S0Z6L2cwVHRPdVNIM0ZRTmNy?=
 =?utf-8?B?c1k2eXA3VnlIYWNyaEhhaW9FUngvQzErNXRmMEIwQVQ5ZjhtS1ZHQ0MrZ2lm?=
 =?utf-8?B?djZLZVg1NFNIR0NoeUhmSlpEQXVLN3UyYktubWovWEVFamFYV3lOcU1YNlE3?=
 =?utf-8?B?aVBmbzNBTGRVQjVDYnBYcytvZ24ya1FGZmtmUDFXcUFPb05GYVpubFRYTUZp?=
 =?utf-8?B?Q3UwNXBLR0NiVVBCR2V1MUdScHlSNkhaWVpjNEx0L2xyeDlGL3JveDBaZXBV?=
 =?utf-8?B?R3U0UWJuMmVsSERxMkFpbGgxU0VMTXljakthaXl1dmU3eVUxRlBkRWZadkN0?=
 =?utf-8?B?ZnY1UW5FY1R6L21QbFB4VXFzU0RTOWZaRlVpTVdTcDNRVEppVm5VNTBZU0Rh?=
 =?utf-8?B?OVVmUkJ4cEVMK0N6dWdOUG9LQmx1NkRRRkxaT0cwWGFrcEdTelhMaUw2djI2?=
 =?utf-8?B?eHl1Q29BZUFYL0F6RzVza2JSR1dNZEY5RXEyMHFmWElWS0JOemFvenliNHNa?=
 =?utf-8?B?UkQ5K012S2pjVmtWbGNrTjB6Nll2eDdjM1dUbFF0SUc4MXBwcHB2Wjl5blp5?=
 =?utf-8?B?SHRvOTlZcWkxK25uYU1OelVKUERWZU9GenIrYkRFUURWc3BiTXJXakpkamox?=
 =?utf-8?B?WGozWHlTK29pYm9lcjFXc3psK0xVbm5Cb3dSY0FZRm5VNEoydkRvZ2YxZ3lj?=
 =?utf-8?B?bkZYVTJ4SlNoZUxnNkpPdmpHRmdNOEVBbGd3YUxvM3NyeU9Eck5vMW95YTIv?=
 =?utf-8?B?VUovNDJjanBNUzgyb21aVHRBSUFnL3p4UUNXb3RPVkYwMW8wRHpYZHA4UW1U?=
 =?utf-8?B?VGp4eGxKZjJMRDI0eGpYZTZsUU5pR1oraUVFcHRwd2JORks5eEI0dEF5d0Vq?=
 =?utf-8?B?ZHNpUW1RTVlEanprRmV4K05kMkdUSzRFQXJ4UGRTRU5TWExmRDdpZy96ZldJ?=
 =?utf-8?B?RkVSRzdGWWp3bUhtZXl0c2J4eFRuc2JnMXBGWmN2a0gyTzkrOWUwWUVNUFNk?=
 =?utf-8?B?aStESTEwYm16ak1zRHFjRDFhVHdoWGI0ejBUbnJOQm1BVzNwaFhuWGZ6MG1T?=
 =?utf-8?B?UGtuNzl3dEhVRVMzOVN4SW1CaDhxZWU2WXhINUhxcDNENXJuWmhRUXA2UnlE?=
 =?utf-8?Q?ng8+Zz6FHfOtDaFoqStTpH0RLB1/hnelDAm8tExySM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <732BF3D649FBE446ACCCC5E0D9699A0E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hHN/nFtbQAlpDGdppqvryKbLATLEg5QJyjThPfatvvK9UCtuxOPXy14B7m3vMhdn17Ira0RNSsXY2rI68AzDNg1LCzzwN0SZsaUKq7mU7m59TQHwO/fWaEq32MTyhBuTnMR0Vzj6tGjDO6jXf/IrxyF1gYo25qHODP7pnFA8WybR1P/STXqIoLqKYlRUqdTdeB/6u3R2SowzyuTYNVah9l86aadAHh2AtVTD5sXGiVF9dbZ4E1Yexq47BMS8jv38XDP1um7w5kWUVVETUrdotiAVnDItjhlgGfDUhFYcp25IyCAzQ4sqQOcO7oQoJrm/Rm1pPKLJe84pHItst23aeUZWDijZQyi9kMJ8G7Uz2rsyixW667b+nJwA0IBpHX5R8xfoC3okfyLkcDPFImZrERt2x3TWwyi9ioV/HRiBPv2S8tehJBP320Y+Qn9x7sXnK/5z+0X/TdmvW+4UzrWvVoB+xugnZspeXwQiOqwii/GWp3kRs3aQuYsnFAem32A7sDqiGa9xUpnfnuqcG2NR8qhS4/S2BritxXAMjMfd1V9n179Yf9NIb97eFDx2kwMSyKqwYsS8YzD8jN6I8z6V/E5RQ1LIrluzxzPeouGwosLpDhN2QqeJIV0zdBGa4GjcbxJbjx1vWCA86OGx62RvKWkwV7sYG/C3vJtpK0Ky2mfEB7xSh4zbC8HzxLP86kE7Lpf5uhxEc+2eSfYHPxb3U3hoiXGqwx+B9MLi/POxEoZVMkYKYTusHhjOcQWZsaXb3dTYeCTKLQz0/aov+KtxcpdTkXIu/4S/V0dBiyQ33mcrX/15qQdA53DnAp1Lbhlp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508c8f2e-aa20-44d3-1e6f-08db0dc3fb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 13:12:38.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3+BxFo0WW97DDO7wt86rVyhyABn2J/XINleIzKn/qFlxgwDWdCaT9QcWZIZR7iEGSVqIJsqAyBmRIKT6Q5Y1U2qBk40sFp3ZJXp0d0Si/rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8104
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDIuMjMgMTE6NDMsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4+PiArc3RhdGlj
IGJvb2wgZGVsYXllZF9yZWZfbmVlZHNfcnN0X3VwZGF0ZShzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAq
ZnNfaW5mbywNCj4+PiArCQkJCQkgc3RydWN0IGJ0cmZzX2RlbGF5ZWRfcmVmX2hlYWQgKmhlYWQp
DQo+Pj4gK3sNCj4+PiArCXN0cnVjdCBleHRlbnRfbWFwICplbTsNCj4+PiArCXN0cnVjdCBtYXBf
bG9va3VwICptYXA7DQo+Pj4gKwlib29sIHJldCA9IGZhbHNlOw0KPj4+ICsNCj4+PiArCWlmICgh
YnRyZnNfc3RyaXBlX3RyZWVfcm9vdChmc19pbmZvKSkNCj4+PiArCQlyZXR1cm4gcmV0Ow0KPj4+
ICsNCj4+PiArCWVtID0gYnRyZnNfZ2V0X2NodW5rX21hcChmc19pbmZvLCBoZWFkLT5ieXRlbnIs
IGhlYWQtPm51bV9ieXRlcyk7DQo+Pj4gKwlpZiAoIWVtKQ0KPj4+ICsJCXJldHVybiByZXQ7DQo+
Pj4gKw0KPj4+ICsJbWFwID0gZW0tPm1hcF9sb29rdXA7DQo+Pj4gKw0KPj4+ICsJaWYgKGJ0cmZz
X25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKGZzX2luZm8sIG1hcC0+dHlwZSkpDQo+PiBUaGlzIGp1
c3Qgc2VlbXMgdmVyeSBleHBlbnNpdmUuICBJcyB0aGVyZSBubyB3YXkgdG8gcHJvcGFmYXRlDQo+
PiB0aGlzIGluZm9ybWF0aW9uIHdpdGhvdXQgZG9pZ24gYSBjaHVuayBtYXAgbG9va3VwIGV2ZXJ5
IHRpbWU/DQo+IA0KPiBZZXMgSSB0aG91Z2h0IEkgZGlkIGFscmVhZHkgYnkgdXNpbmcgYnRyZnNf
ZGVsYXllZF9yZWZfbm9kZTo6bXVzdF9pbnNlcnRfc3RyaXBlLA0KPiBidXQgb2J2aW91c2x5IGZv
cmdvdCB0byBkZWxldGUgdGhlIGxvb2t1cCBoZXJlLg0KPiANCg0KDQpBY3R1YWxseSBJJ3ZlIGJl
ZW4gY29uZnVzZWQuIFdlJ3JlIG9ubHkgZG9pbmcgdGhlIGNodW5rIG1hcCBsb29rdXAgb25jZSBw
ZXIgDQpkZWxheWVkX3JlZiBoZWFkIG5vdyBpbnN0ZWFkIG9mIG9uY2UgcGVyIGRlbGF5ZWRfcmVm
LiBJIGFscmVhZHkgY2hhbmdlZCB0aGUgY29kZS4NCg==
