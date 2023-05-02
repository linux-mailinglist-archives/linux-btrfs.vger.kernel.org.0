Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98FC6F4369
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjEBMLG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjEBMK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:10:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4715B85
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683029424; x=1714565424;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=76rrF4wvlKv+lG4bvyRv7u3JpYYUhXKQgSr1AmLSEjk=;
  b=qq0lCEBytHMePTZfgY0Bnzj6DYk8rcowyeRgo2ASIqjGnbrd2ANXmBW2
   +AQSNggV6mUEYv7qh1fRzjfK+LXM/DHQ2QEujECV5wizf5lrgmViTBbCa
   EEGPz+FHSXODzWLU7PLh4IBoPTBzDRNvM6xzIqRjDjaD85dx753IvcuLH
   Abrg2xy1DH+SRuQoJGPa3IHTVwoAFGtw99KNP69ko9ISwFOZRP/l2XUuX
   oOvswWpv67J47cnlFwTJ30TfCKy10xmK4XEQtplgIJ89EP7bR0oryZUjd
   LeM7QE95q65HPp0CB3XWa1EsW31ocJ85lqqZthqg26ABgr8bbX4GrE0NO
   w==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229742193"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:10:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFOoKFkUYonWYx2dOdFY1+QuE4tUZqrJkI5sSumeQ+FJ2S6khBZ/cvS/j1lIWzE33azRxe12iuVIwyyCFBhxFW/lCtir5meHac9fplAL2FAspntYDsrb+CotPmx9qWBCBnVhnm+dN43U/tSJSUKdBd1x+2lSEbYnvbN46zE9BrYtwPVX4uWhMzpSjWGGuqOW9CcO4J5fsvOGP2L1AyJ7WqllrVNfVn1+aCDe+w7go1wBK2j2E0qNNxL0lWxuGnwB7G/BOCRaK37t90ftLdsV0QWX2Lxl9FP405HvY7hqb3XsiAu3rdjwETwXkQ5vJmP7CfIePzu5pfAAhes/KW2CSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76rrF4wvlKv+lG4bvyRv7u3JpYYUhXKQgSr1AmLSEjk=;
 b=QeZ473815krX8nzbSKcpr/rlLa4DNdYuN+eapltBAMOq+ME82SE9H/BatTHxrSfcceqGRcfMwEErvy5G4c8zd4h5T3Mo4O6sK6WlWC1zo2aT/pOIm3XzCQ+l8cdf53ipGsdKW+n3yTlqZ55rmsbMRgezycrL3Y9s/Z6W+IsLdfFwNt3QZGSA/GPo2RaGP1Lu7fmzKU7nryZ09mYBdqc5igkFJNUDKSE9sa4LJ0GMsaMXE0/PvXQuSxMrXJI058gS5ivKIwaD/2iBrQOBB9g3QaZQY7SanoZfNWwYpiPRlK1Cnp8k3KMUlIq1pHUlZ4rmuKuNlKpzB47GNzJmS/+Y4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76rrF4wvlKv+lG4bvyRv7u3JpYYUhXKQgSr1AmLSEjk=;
 b=Uq9Dh7zRajk8UAUFod0RFSOf2zyKu0QU1t1LfXGNrv0RGfKzAAOcoBE5DYaMKip8FlOCZPjEWo8nf9V3gSYLyUUSUPtdTsQ6OhbIUCVmyLekpqkvMjJhIAkJah9Ufon5sKyb46gwOeIr+H+YpEkj/LPpD4CA/+usLGXMsNALm4c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7487.namprd04.prod.outlook.com (2603:10b6:a03:321::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 12:10:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:10:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/12] btrfs: add __btrfs_check_node helper
Thread-Topic: [PATCH 07/12] btrfs: add __btrfs_check_node helper
Thread-Index: AQHZetZNu/RlwvTox0CM+FzyUZ2AmK9G6HQA
Date:   Tue, 2 May 2023 12:10:20 +0000
Message-ID: <ed882c49-7947-bfff-2b93-07872528fea3@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <c78571e0ea619aefd33e2c6d1a6ac274cb15581f.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <c78571e0ea619aefd33e2c6d1a6ac274cb15581f.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7487:EE_
x-ms-office365-filtering-correlation-id: 4ec70da0-453e-4500-527f-08db4b063371
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFTlB9vtYPC7MtKBV+oijtVSFuE+WBztTJhC9IQNSq+hin0VCRzrOSj6K2erAxE1LKq8ASQh0c0VYBM4zgn6NPb5skoVplfF2x8VUH5ueOvtxPQhNjx/nkeMvFi37V3oW95YQgtssxff26uEguFlczuXjpT2jRRbLiLg874Vjzl6s3GiQjLugjj8JMAHePjg8iY+FjWvRfEeW855l6/aOJTUUcAQlCp/FolCXt9nJ4h1JyKJOoQ22l8yeXWHIlnQOlQPh/xJ8iRN3Zm3OA4eAkZ1/spiTKbdCVEZJMVaRBtcfAX9F+stqI5ddwofsPSFhroz0v+EQNSBfE/aIjJyKY6zAjF0nOkcQGE+yxmJ13wsBCA2Yxmu8RMSmtX87qmZo/MykKl/3Y9p0LVn600Kx84JDJmjDYkjWGS8H73glMSP+mrOgdDkq28qr/Wxx+m32NuYF777WtRf+6+VxFVfHJBszFUwpPrJMD5tA6k1iSuFMW6YBjsvFeRtDFR4NpWN+L/F0FqUwYadvpzbRbp0xAhuu7jCpHGRWmZNJPAKliq75I7knh8f2zMXuhsq4JmPz71dx5lZqDKGOjyUnhPwVp/ggZumRJVuTfJ4mYC5FePAAL2hebSQ4+VIeu4OvOZDv3mC9QpmqkOFg6WGEqGWVx5Uqk0hGjF4hIYe+rWb5BAnISvIdhFxJ0/gDcIs2gWL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(86362001)(31686004)(8936002)(8676002)(41300700001)(5660300002)(122000001)(83380400001)(38100700002)(82960400001)(38070700005)(31696002)(6512007)(6506007)(66946007)(76116006)(71200400001)(66556008)(6486002)(2616005)(478600001)(110136005)(316002)(91956017)(66476007)(64756008)(66446008)(36756003)(4744005)(2906002)(53546011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFJ4UWt0ZENrZDUxNkx1SUp0WGdyWGt1VDdKT3pXTkcrRERJSzZjS3ppaXd1?=
 =?utf-8?B?ZlJUVUxGL1k5aFpGSVIxUVZMUWFmL0VtbVBMcERqMEgyaDFXRDlYQTZHSkFZ?=
 =?utf-8?B?NzlhN2RiSTJqVGcvcTNCWFRIRitWd3R1dG53L1ZZeGE0N3UvRGNjTnNmVUJF?=
 =?utf-8?B?TGsvbnF4RkdyVHJFU2FTWjZqNTliNU56dHB4Y3A1T04rUC9zME5uUEkzQnlP?=
 =?utf-8?B?S0p0WkVDeFcrNkJQYjBlSGd5RzRrYlhqRy90M3NBb1dncndOcCtNSUFib2ZH?=
 =?utf-8?B?ZExCeFgvK2JSYVF4NUtQYXNWNDlIeGFnMm4ycVVWclJLOEhPZk92SHdJOWNY?=
 =?utf-8?B?RVc0WXJRelJhN2l4Zm9ETGd4OVBqL3FuN296QmR3bWJuTkNGRU9DbU82WHFT?=
 =?utf-8?B?NXZ2UFVsd2lVUjBFaXBHTkk3aTJiODZmVlNRb1d0ZWNmY2MyYm5EV0JPbmdF?=
 =?utf-8?B?R2thakc0empyeWNpemxLYUQ1eDBUVUVPYTNlVklrSHIyRXE2cHJONlVCNTRy?=
 =?utf-8?B?cGo1M0Jka0hyYW9hdVp1VG12dENDc3RvSHFwRkFHcUEwNWRYbWVCZkNIRmt0?=
 =?utf-8?B?OXJsS3V5OVNpUWlWaUZGcWJUVEg4SjBBL0IydTJrVU9TbmkrMlZZMHlZdHdS?=
 =?utf-8?B?ZWRXdkEzSE5icGQyWWxlbStQejA0Ny85eHJkSkZhZ2U2RUkzdFlTNmgxRDBl?=
 =?utf-8?B?OGxqeUR6RXpGQms2dnhJcnRCeHh1Tk9QdDZwMjhDNmtrVkFkcHZBM0Q0Rld1?=
 =?utf-8?B?aHJKay9VQUtlYXRyTk9YUU1Db2Q0eU10eTlKdW9weVdCN2wyZzNtTnB1dU0r?=
 =?utf-8?B?a2dNZXFTWE1YNTFZaEZIcTg5QVBQUk9ZWkxJelhtS1NpOHlldmRGMys2Qmh6?=
 =?utf-8?B?eWh1b3pacWlpMFExSmhhaVQ1MUQrTHRmOUlYc1ljUGdkOCtnelFuVHZxdTRx?=
 =?utf-8?B?L3B3N0d1N3Y3aiszbVpQNnRaYmNTZWZCNmgvVGZ5dFVXRUhqTE56RDhhQ0dK?=
 =?utf-8?B?S0h4eGNUbzU2YUpNZnZFbmRmSnpUbFNlc3Q1cUFWYTZ1ZUczdEkxRGdUejdi?=
 =?utf-8?B?aDhpSURZOC9EZ2YveU4yZjdmWkZTaHRsM3hVSnliQUg1RVhJbXlqOUIya0lF?=
 =?utf-8?B?SklNWkhvT1ZMbWFLT0YxMmcvd2NYNU5MWitzait5bytkaERTODZha2J5WW4w?=
 =?utf-8?B?b1F4UFpTWTJmMlIxMzZiOTZjdDNKVVEzdkdPNlJ6SnN6MkJLeGhoU2VEVzgv?=
 =?utf-8?B?azRqSE4wTXpQZUZJTXlsQXBXMlZxRnlUY0w4NDVCaS84bkJOWkZyT2E4NWRm?=
 =?utf-8?B?WWNMWXFYamJ4YzJLbThXYlVVZ3NJOFZTRXVKVEtBR3NSZThwS1dMRWx4SkFU?=
 =?utf-8?B?bFo3QVc1dnpsZTVYWi8xRzY2QTAvNUhlSlR4dVJWNHBNWjREUFpWZXltZU0y?=
 =?utf-8?B?WkJKTWN1R0ROczU5Skt4Mlp5eWhhb2JxQkF5UHV0dFpOMWZLdER4Q3lweXRy?=
 =?utf-8?B?bnM3V3pFUGhDelBiTkFZUWgxa3Bja0JMcGxsVThjWDJOUWZPbWo1T3B4SFkr?=
 =?utf-8?B?Q21vVDM3WkcybC8xdTBKS2JqbSthOGdtWU1sbEkvQ3JnY0gvcmFvbXVUVUpR?=
 =?utf-8?B?OTdxTW9ENTdqMjVVRUN3MVN2NklPUDlNVWprVTByU3JtNG81TktmSGtUZXhD?=
 =?utf-8?B?ZENuN0cvMU9IcW45YzB5T1JaeDZybElJSWR2MWFWU3QwUGhsWGMvTCtlTEdq?=
 =?utf-8?B?SkFtaTdVUnpsWUNVY2NyZjhMcmJyRkU4STFNditJcGU4aDRhRXRudWNCaExt?=
 =?utf-8?B?TklWN3dpdzZSWFFvMnZIeWlqb0cwNVEwM0VRYmxQbGRJV0cxdFY2TEtpUlNQ?=
 =?utf-8?B?Z24zSlVpSDFmMzZnWWZmMXJ6R2JYbmVBQnlvNm1lR216S2RYNnNoNko5S0pk?=
 =?utf-8?B?VktCc2V5NVIvUzQvejFEVllPc0RucWNsNXAxSEM4QjZEeVEyMnV3RTVGSmZs?=
 =?utf-8?B?MGpkdGJQRXBLK2dxS1QxcVVVUVgxY283di95QjMwRkJCUXBLSm5ZdHpwZjhD?=
 =?utf-8?B?N3hXMGFuVjBSOEFhTnU0M1g2R3lCWGQ0ZjZGaThKNGF5SGV2ZVNqWmFwdTc3?=
 =?utf-8?B?UXorM0ljTXkva3J4RmZRUVJhbWNGM2xYdFQrME9KZkR1RnhKUTcvUE1jSlEr?=
 =?utf-8?B?NjYxMzJHVStLUGhzckR0RXZWSzBRT3NqU20rMldzMUE4cVpIY2dKV0liQnFN?=
 =?utf-8?Q?SUe6F/J5f8F3H0+mqk0X18oZs2lhIfrpuAQCUGZccs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966CECA92B20DE45AB18B567B649072B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mjkW/j6DWyn36EtvDuDhVxjZSNP2GUWkHG69WEOfbSp8uAUHqYwc7Nf9XX3JaRIiB7HmF4xccY6PRMaT/xDA0qmZasqgg1OX1imiA+KAvbWvA2G821kvsIHq7wMqhiCEcZ0JbPZ+keZ+0DFBQYHAq5sC1NIS35cm78qrx+F3OH99RUTfTYwafaHbA8JL8iUM5zWAIzIB+sDFmlNTFDtc0mWmkuVvbLvZaqs3hrz71jHRUYSmDG1dyB9Rp+ZUpRM67RMod5rMHxEux/mQmZO9TlswDeYG1pfNQRTayPRPAhz+YICoP2Gw+/eA2haalpe174vkd1C/9Iv/Bo1ayw1Km0JY2Hdua01czhKeCdbvK7OhBHejX/dqjlsn2xvX0iCQEb2MUWRVleXrTvXYqEjtA4u5V8clZNMMnFMZcKoQ2GGTNNcnnslrybjdoC3UtkgxRhoeROssx2rxiEfHBhMHAgYyOau6271EuC4Zz8ljgcj4XWlrdjP1vZPoi9nam3AVGoYBlsFFLolKJB1C+b6JmnkYJ2ChFG6cJO5vH9URFHzDk1hFe+sz4k3CPxhFGRNz1HWuiOmsYAJufFs1C3b1HMBuwVcG7pa33k8Qg9eRbQac86/n5o2Z77oHZrSOOUHU+zNjb5XwMc1A5pwsK4mHoB1lwqgDzFqjVuQ06V5FQQ0yFKRl1C6lg5tvhqHZmODHyf/3vlkPbHkX3RwgBT0J6Y2T/64SwYHUhISCnHu9PtdmfPQkV22dnmb+UVYbNNj0D9TybEMBGeOsuSXhLxZZYvYAr2sFASZeNtucNXQ7KScfgACEPKIiuqGvL53YW/NZI0h+EbOXfeiAjX0qg1QV5g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec70da0-453e-4500-527f-08db4b063371
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:10:20.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/OW+j5hV0h7SZjcugEbtb+HS28U50F/99wj1tBt1IcgJOccpHbf4tdyVdEdsQd8FMk9a4YyPtm8n66Nj0RvSN7gN9EHA91e7y8dYtMUQA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7487
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDQuMjMgMjI6MDgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvdHJlZS1jaGVja2VyLmggYi9mcy9idHJmcy90cmVlLWNoZWNrZXIuaA0KPiBpbmRleCAz
YjhkZTZkMzYxNDEuLmMwODYxY2UxNDI5YiAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvdHJlZS1j
aGVja2VyLmgNCj4gKysrIGIvZnMvYnRyZnMvdHJlZS1jaGVja2VyLmgNCj4gQEAgLTU4LDYgKzU4
LDcgQEAgZW51bSBidHJmc190cmVlX2Jsb2NrX3N0YXR1cyB7DQo+ICAgKiBidHJmc190cmVlX2Js
b2NrX3N0YXR1cyByZXR1cm4gY29kZXMuDQo+ICAgKi8NCj4gIGVudW0gYnRyZnNfdHJlZV9ibG9j
a19zdGF0dXMgX19idHJmc19jaGVja19sZWFmKHN0cnVjdCBleHRlbnRfYnVmZmVyICpsZWFmKTsN
Cj4gK2VudW0gYnRyZnNfdHJlZV9ibG9ja19zdGF0dXMgX19idHJmc19jaGVja19ub2RlKHN0cnVj
dCBleHRlbnRfYnVmZmVyICpub2RlKTsNCg0KU29ycnkgZm9yIG9ubHkgIG5vdGljaW5nIG5vdywg
YnV0IHNob3VsZG4ndCB3ZSBkbyBzb21ldGhpbmcgbGlrZQ0KDQojaWZuZGVmIEtFUk5FTA0KZW51
bSBidHJmc190cmVlX2Jsb2NrX3N0YXR1cyBfX2J0cmZzX2NoZWNrX2xlYWYoc3RydWN0IGV4dGVu
dF9idWZmZXIgKmxlYWYpOw0KZW51bSBidHJmc190cmVlX2Jsb2NrX3N0YXR1cyBfX2J0cmZzX2No
ZWNrX25vZGUoc3RydWN0IGV4dGVudF9idWZmZXIgKm5vZGUpOw0KI2VuZGlmDQoNCmFuZCBpbiBm
cy9idHJmcy90cmVlLWNoZWNrZXIuYyAob3IgZnMuaCk6DQoNCiNpZmRlZiBLRVJORUwNCiNkZWZp
bmUgRVhQT1JUX0ZPUl9QUk9HUyBzdGF0aWMNCiNlbHNlDQojZGVmaW5lIEVYUE9SVF9GT1JfUFJP
R1MNCiNlbmRpZg0KDQpKdXN0IGxpa2Ugd2UgZGlkIHdpdGggRVhQT1JUX0ZPUl9URVNUUz8NCg==
