Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35E6A81F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCBMPi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 07:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCBMPg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 07:15:36 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E941EFD5
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 04:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677759335; x=1709295335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=WGnZQHItWrbkoXNLmQj5vqvkCdbFsuu/MfKYsgORmlgvfhDGcnbJtbsk
   dAArksgAqmiN1nxQJXTFOSgt+hPeKaFQD/0ySLeMX/rb3fjRuJ28pyDNm
   hjhhIh3UQqE7t2LbjHEma8Ya9T9EV2zwbOTDUZzr8DgC/KW8okQi7ogke
   7v37mPnPAQ11Z9UZ7xUxeQVVnR0KmLMd4TDTcWe0UsXhUh7hTF9mxuHRl
   X8cc1s9afZTVXXkDZa4h+loZdp1kWVEgcXAH/le+8usEntpowtyvnk7Uh
   wrtCzL8M76unBCUNhOr9GsCgrF+NztHGyNMTxrYvpisU3EtHKzhjeogXK
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="224408019"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 20:15:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUyDDTh+K4+GsYlLa9EOPsJp4GUwhVDfZHqOVedVolLcRcfw8zEIWCWk7OTjk1U14HNFGhDgSBx5/f1ehgEwH9UPNO/yZ4hfNSaNuXd0SsSn+4QqVf+KYlfAv1gIP0dGFbSY6k1FpNV1WIXAO7smoP3R/2CF8qD8h5z+vD4rYlWTHayE4MUPPayJXZhgdx/y4a8KTT60OaV7yuajbF5K3pqgKUQXi28FV+Q7ZrZg9yBvzo6XwQpXzY+deAMaGwqQ0opF/fGrzl6Yq5y/s2sWnPy1aKWvzWHSxaT8f0apdpoVZP5D8dPhF0JWHx6mpGkvwIeq2MvVh9oIztuIVUlRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=arjB1b6RhjuDWOB9cumoxQUzHSXttLq3YH+7Kdq4d7+N28cn2wvmZAvhzArXjRuK1eHX/6UznLgfvklJuorFuAPo6pveGo1sR3IMW7+mkqvlMWHxsGp2SpJZnfXvqQcnGn7u0Ox2uXvmjyBQg/t7L2GN/7CIUyNFJCNSME4RRmw/3/oeBRU194q9IixhXihB83m6+oPdkjiusRVnNGikWntXRxDpj9S9J9TlsTUOKPVFP1nqlk6TePYcKc5a1Nf/qrdAExVOoAe7gVr2k/qc7w9SL53KZu5wEYfpLIVu88UsWXfpdA2tYfV2tOrCVxybw7LZ5YheMZNrTh7NByZm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bxyBPXuRAJ3v79UD3v+rWepTpnhaA/jalsGvRvCjTsFqzDOUGwH2sT9PQ24pNf5tLY6+x7CalQZrzmv9dEzWnuG4WbRXa9om3dwpOKSSQSySODbkjkGMqv1zU4vfMpgZ615UT6UTVEUVlYkCPhP08vxJk7k1RN8Uw5nRWGZnHFo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4334.namprd04.prod.outlook.com (2603:10b6:805:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 12:15:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6134.025; Thu, 2 Mar 2023
 12:15:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/10] btrfs: cleanup
 btrfs_encoded_read_regular_fill_pages
Thread-Topic: [PATCH 02/10] btrfs: cleanup
 btrfs_encoded_read_regular_fill_pages
Thread-Index: AQHZTEO9WUeUVVqP10uT4x2YJcFkx67naNWA
Date:   Thu, 2 Mar 2023 12:15:32 +0000
Message-ID: <7de7dfda-9931-da55-beab-96e8e3eee36d@wdc.com>
References: <20230301134244.1378533-1-hch@lst.de>
 <20230301134244.1378533-3-hch@lst.de>
In-Reply-To: <20230301134244.1378533-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4334:EE_
x-ms-office365-filtering-correlation-id: 32f57617-993c-4949-dbee-08db1b17d20c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJ6Ezo/VlEO7YX906gtl7sdtzP2YjXI4CvtC14WL5+XAhEqhuHnIJKMlaRP84MCso5D+q+ZjTznyZYciEWVhd5q07qYFQDPP+6Fm4047GQUkdyrvG/Uq2HT0u1xJ+wr8AU9CxC5qnF9EduvvQV+BR9hrzXJMDCXfcIj0yXQyk2+4Ac8OvCostu2RZikLaT2Ezfos77EL2oQflO0xgMUCYMcXTEZmjXDajtD8yutbMKyjCvDb1rqTGa+8qLdSw8JAOSIRUu6MBkKJY7ZPm656l9W4BDNKoO9HyjS2fgYsUhaKNWGkOcuZneed723jCtHsvF2zAM9RlR8C7OPxmMYtoAeoNUUUxzRs8fDvdrKpyuVeeZE5h4dh7EDTooL1Tqho/wmLgRxrQpkZcGkB8nK0bw1hQq8AwmqfjxURuX68AjfpT78Ct9Oahmaj2SASnrrNrLSEYC7UlAEE/s0mpdge9aeqRE+iw8x+kTjmnruU8gBp+xez1j0hd1jmrGxMmHudjk8EjeFZuN4ZkIwE6gKkYJiQbft/FSU7bIkUkxK7EsVtJFJ0rMpX7VcU8OFkmY5FQ2zkdzZFuE9OSqTWfpSl/gUh2vB6nfnjl5P85o7rhN2xH9C8TVa/K34ER3PpxwKeO06pEfePa79P9l9EbMspEx71ImxXbPn2FKySEljVhrJtNq1e9z2OnLhoMfgOL2lmihyZt46PAr8V0cjJVBZlI7ru24Cx1uGf4hxY/RfJM86glDDnu3mOGUkCcP/h8YRBwaVGi3t01g/uVXTyh+KYKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(31686004)(36756003)(41300700001)(8936002)(2616005)(6512007)(8676002)(4270600006)(66446008)(66476007)(66556008)(66946007)(64756008)(186003)(4326008)(76116006)(31696002)(558084003)(86362001)(2906002)(91956017)(6506007)(5660300002)(478600001)(122000001)(71200400001)(6486002)(316002)(110136005)(38100700002)(38070700005)(19618925003)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUVhNnlsaHhJRXp4Mklmbkx0WkdtOWZNVUp2VWhiWnhUSC9lM1JNaHhyQnVy?=
 =?utf-8?B?eTVNTkkxakgvN0lMSjFMc2hmalZwc25jMUlMY3hUNlVXbVRVWVFhY29iV0Y2?=
 =?utf-8?B?Z2lXWkhXZU9EdFpQdWNZZTZxZzM1QVdnTHY3ZjMrSkNMTEZTSW5IU1Rib3Zu?=
 =?utf-8?B?dkQzNjRWTTN3MWRKcFJ1bjhVK3ExRk9SRFFPaDQ2Q21YZGt4Nzg1akZnRldR?=
 =?utf-8?B?ZGxBYTFMT0lOQzB3NGpGdkNpM25tQ1NER3U0WWNKZWtGNVJydW5PQ3hQZTgy?=
 =?utf-8?B?RExmUXhyZmdyb3E0NmRDdWhRNWVoYlhBQ2p4UnR3SndXZFlvSDVaaU9nNkNF?=
 =?utf-8?B?aUl6dVF3UXFrVUJmYnhDaVVsM0xXak5pWG16VGVoYU0vWEpuTEpWZ3ZzbWhh?=
 =?utf-8?B?UXNRWEk1eGhCZG9VYmhhQUQ2V1Q2YTNqd3Ftbi95M3dEV1I4Vmx1L0ZkVCtk?=
 =?utf-8?B?WDhRTTlRT2daakF5NDh0K3BLT0RsUXB6UE9OOVJvWE9oanFGZi9JZ0g1b3Vh?=
 =?utf-8?B?VS9KM0FBNXdKWllzME1wZ2VRMW1ZdFRhSHEvclRnNkx4Uy9wRlpvckhNWW5o?=
 =?utf-8?B?QVZLcmVPL2RMbHU1b29TM1lUUHUwWm1pNjViMGloUCtXWSt0T1lXUkNrSFZa?=
 =?utf-8?B?R1g5N09jcHhjNnNwQWMyMDh0eFdOUzltMTRKSkJtTG1SV3VwQU9neVNybWIz?=
 =?utf-8?B?UGIvZlRwOXFvZjlWbENxajRJeC8xdXExNnlMcUtudFMwRUEyQ1huY2JSQ1ZY?=
 =?utf-8?B?dGpHNEZTYXhnckpjVm11elB6YjNMdWJUS1hZLzBKdUNjdEdlYkpBT3lUVU1i?=
 =?utf-8?B?ZjhOdGZkb3VOT2c5c2syYXB5QlEzZzRGTzB3bDZKKzduM0tFVVpMeVNpU1R2?=
 =?utf-8?B?UkFsZmNQRGdBNnVHcGFMY3llODhZUlg2eEE5WUlJcUNTOU9oaDNWdWhJaWc5?=
 =?utf-8?B?blRndjdweFk5cEZpc3RNbEJ5elB4cmJEL1lyVXd2RTgycXlHa0FuQ1FUNHAv?=
 =?utf-8?B?TXFDbkFEKytYVjNxT3RleU41RjdGemh3YU81RThtSm5xbkdvVXIyNmEvZW9n?=
 =?utf-8?B?Rm02blZCTGM1L0dwSjFqMldhRVYzYW5SKy82NzBhdUlzdUtmZmkrbWUybXd3?=
 =?utf-8?B?QU45bHNQaGZsRWdSaVIzQTNmS2lKNVA2NU1tT3JLTG5jNTNrTDZSNFpVN21O?=
 =?utf-8?B?cGhRTzcyVVBYZjJZRU0xc3EwVDY5RFFJOHRuMHlEYnFKOFVhZnZGcU9YVHR6?=
 =?utf-8?B?c2tyUGRwRWVPN2RYNnRJN3F3UEh2bTJTTDRxVnk2ZnZUbVNuVVZzbjhmd0M5?=
 =?utf-8?B?VmVrWXB6blNKUUhoeHBsYnAvQktRSGlNczNsZTUzckp6WHdkcFBTa1l0Zlhq?=
 =?utf-8?B?QkF4UFFqY1YzSktzcTZBMzY2WkdreHl2dys4bDFmaFRUOWlUaWRZMERiWjU1?=
 =?utf-8?B?ejVYdDN6NTBqVVBOamZ3TUt6bFR2anMveDJ4VWRCTXlkZGhEblV4cjFIQ2NH?=
 =?utf-8?B?dXp4S2ZPVDAvaG1kbDRrb1NzOEIweWxJSVd1K1VUMW9MZkhkK1ZwVTQwbDVJ?=
 =?utf-8?B?dEQ4Tzd6Z3N2SmdoTUNtMHdUbnVTM2htVnJodU04cWlHMXVaTnQyVnRoYTlL?=
 =?utf-8?B?akN6SzNOZ2V4SjZ3cDl0SjNQaUlob2dyL2pDR2NCTjV6MUZneXlBL1AyZ2dJ?=
 =?utf-8?B?b1FpdjdYL2lJUFZ0bEIxb0dIWk5lVUFCdjFBSUxKNHRmaFdURU9CQ3hCaUho?=
 =?utf-8?B?SXZVR3MvYlBwUGZ6N2x6WWpWTzJFWS9aWEpUalVubnlwMVhYYVpOcmR4aTQx?=
 =?utf-8?B?NXpwVnJwZzlIbkNIM29TNU9FOTFmVWE1KzRxN2w3bHVTd2FhbngzT2JTSnpF?=
 =?utf-8?B?Z0V3eWJDWXRSK0RFUmU2eVlNSitVcmNkU0VNcGZQclNqT0NBalh4R3l3TEsv?=
 =?utf-8?B?MUxHK1Nmb3JiWTFCdmxZYlh6MEN4enRxWXFSdkFvQWN6NkdweXhwZG9SMlZ2?=
 =?utf-8?B?VkFiamFWMG01TU80bWRNT2tQbVoySHBIUjBKZnJWbUp5SVUrSDlKYVM3dXZ1?=
 =?utf-8?B?SFkrNTNObGt5WDl3TFVPcXZpMHJXUTl4NjlWcXBMQmhQS3NLeXFGSDByWGww?=
 =?utf-8?B?dDQ3MGJXZGxUQVg4VXc3Rll5UldtNU1rN0hTT3doTy9HTngvaHJuNHB4TDJR?=
 =?utf-8?B?andNOWdCejFNTHp4V1o2TWJjUUlUb1RNSzU1WU41WnI3TURSS3VsTE1KZXZO?=
 =?utf-8?B?NnNKbWIwZXh6ZkFqTkMvc0lVZzB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32FABBA2B2C2974D8B6C9B99EB4CC839@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z9mJoKv10uJOCsDMZl9IuF4DfkL0EtS6UYYuU3Sp0Ru0b7fQFCphr1UhI+IOVKUrQ7MyMucq+QCerpTdtOTJT0ylKM2E3ae4BkP80EDEYOVEs6+omH+GG7PHiTMMQTwhyKPVxAdcXHjlSsQfMF9n6hq5HuditSfumcmqEMcaGS7dGyxCsHjJbN0rfWbjotyh55gPvhz+N27L9NFC1MEI+jlpCkqulbwjevaionRF4UPDyTAesSrCJ0d7ZYczGjaN7hT+QRND72krVzNCDI2hW1THOn8B4t0QVTGy8RT+claOTLvYwETW9B/YDteju0v6Sq2bkBC7rH5E8qHZfwhF2DjSFDRvV+1gnoXzBU9So1Ot8wFw5uw5Mrk1FboDx9I7QYKER6mz10aFZyHH2l20r7ojbQw7aVp49NRyHRoRGoNChc9LSpn94hFWyyQ7XF4Fa6VRBsCv3Coru+3ofyNpUOEnWzsQ+zClOMmvTYVWynCPrX7HfA14ehjd8IQqHlTMctLj18qkcfpzZwE2Ds98qy1uY8thyiglT8tR4qgPOmMoKkxjdoyjmw5KWEV6r3zNFckPx1X7Y6Bty//nKacBJNEliqsg+tIA5ysAZxaMbJzZILspItrr9Isks2Z/BbifA2XYiME3ddJaZtLVMt9JMUj0Y7+wXN5GXqm+LKfXaw19rZj77Bnnt7WS2r1Q/uIZwCTNxn4NYxqS8KPavcuvi1+2vEdayPMPbbXls8P0drbYkXc94x+yawa1EBSU6eZLaTV0HmPhUjubVHWp79gCS1MaOr/00Bejpqd3NUK+oCrT1H7cTWtKNhqbtvTwanDHeXQ5/vSwhUDLJECkL84VULKDBVmcN4jeUwJi2ciWXQcC7j5BPVbtJcAzYC0KbbpJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f57617-993c-4949-dbee-08db1b17d20c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 12:15:32.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8BbBk4kR/ZWHj6PadPIvVrsjWgSwnxF4YmrKJ2TAtKm6y3nY+6OtfGp6nAhIW0+SbCbbN0SIkBtNCGFxC0Ka+RA9jd8hLoTacM6loPkLLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4334
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
