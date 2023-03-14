Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEDD6B92B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 13:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjCNMHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjCNMHe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 08:07:34 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393A6570A5
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678795619; x=1710331619;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=W+eWM3Cxzl8zsxuRe+cAaoJZPSkFKS7UUkmrbHoQ3CQ=;
  b=aVnJzKWErdsE7GN7XTae2uVyAyN553BrG+yYRVGR4cqeF9u+faSp8oS6
   amn5RV/oxaFnrXn+skMfMqk6S1TE+BuUApOTuwu4JOrkbNN3PtqqN7VRu
   UWJM+Hygkkt/Jj3YWFNMsfEasngK+rNVoJL1bW/1zNQrocLX30k8KsQvt
   6dTUYV+QO4S3VxNbKOla0oIFSS/kRa+GOUYLxDxoJ5BU5q9jOUdZDzIJc
   QGUxMIGYx1lbGuFr12rkpioJByggLBct0s+QKH95hz8lWsPPXB8VP6f+D
   bhltN6LBurVrcqasWuQMbl6aAlR1A5WFagU8Z0Lmse/BSatTWl4zdHLra
   g==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="223879179"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 20:05:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0kThF73afqLE4T+JF+TtpDltSabK1o6gb5drNSkwBSMJpzufxJoLcI7dkE6Q9sLUa4aICEMIUWrW+kpSzLgcUSC5CoZyYURvT92vugA1ghxA4NT5v3PcIBbs+oi9gntI45dlOqU3fxNG3GOc4J61etC3lI5P3u11cyShzGsbi30o9bATW+jWMTcqpeFkbuPBCBSgh8Z5r2qGxmuXDOyTBygE7haJOEKRmey5xwZrIvMALBR2q9540hA2CmDUOL1+b2gXi3DkgnMdJx+flpq6KQ/Pt6rzT1U3WeT8wVPZDkTx1ZVgbrgoFoTcfedOCEriLXfi+6sL4eh+g/5K/vtHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+eWM3Cxzl8zsxuRe+cAaoJZPSkFKS7UUkmrbHoQ3CQ=;
 b=Qo6KrgnNPyd7bP6V1l4kfYRXX5FYGfVU3rucvMGxiUPOE9hg7Z2unQs+j9kdfMyG9QolkRrojdMZ+HAAx7E1Bk87Kove8d9uUuBU+xCV8PdNq5U2vzEGBSudlGb+pZivWz5x6PtApFDm7FO0un0xAaQ14JX+SonfhXNWSQOnELne038u4Mk9gHkM2LTMMCEOUfGfdwJGTQru4zQYoUKIb8VdcjZTku8Xs4ThhJsb0WYMm3NovFWAY+8az3Urd337uPnlFgQ7VNV/PIu/YcD9T1n2uFTcJAsNUji99pwG55Qb9R8Br6WqU2olNp2zdEx2RedyObmbAWxfdiOraXsMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+eWM3Cxzl8zsxuRe+cAaoJZPSkFKS7UUkmrbHoQ3CQ=;
 b=Dg+x4bmwdrUUh7RasNc8+QvorjesdjlMbioS8fYS+jJNz4isBN03fJxqt7Psmh7RuN1bi5sJbp9l/xdGQEsPMBPUnw6W6v+fbdCQOQ5o7XxWnN7Jn0AVDPOEvdYis7NOXHo9Jd8Dktx2trCgHZM02fMkb8o/I5ev4dpKz8iBs90=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0360.namprd04.prod.outlook.com (2603:10b6:903:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 12:05:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 12:05:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Topic: [PATCH v2 01/12] btrfs: scrub: use dedicated super block
 verification function to scrub one super block
Thread-Index: AQHZVkegzByd0LDltUqFaUiU78gceq76LhUA
Date:   Tue, 14 Mar 2023 12:05:52 +0000
Message-ID: <ee70d6fb-2aae-e0d8-8b32-a5e373c572a0@wdc.com>
References: <cover.1678777941.git.wqu@suse.com>
 <cfea13b2a1649e4c295b020f2713660c879ef898.1678777941.git.wqu@suse.com>
In-Reply-To: <cfea13b2a1649e4c295b020f2713660c879ef898.1678777941.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0360:EE_
x-ms-office365-filtering-correlation-id: 363a9c81-4e30-47ca-6ca0-08db24847581
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OOS53kLpYSoqEG1pID4xNwU/lIeb4M+2HxgUXwhTSY8ogtRzc0ZsATRZs5tW3udnKmSKTCBsNt09gwLAFy2p5IFa6tT/qoHSJTSsr9iF5OKH2IxBQmUEC0V+bwMyJRL8Cyor0LI2XVZeBy/Z5IFGyEiqA1E3X/5jLh+uOwcZoFVwiZtV9LGGKGaDEAhObz+J26OGZtn1PCMwpWu/17GCOV2LxFWM7RuJGIVYcuC228WbtJbIUFNoRlhM8dF51f9IYorFJySVecd2q/ARl1WjWWuut7jBm/f6lftez6i3xbdIdQ8UL7D39dk+3OJ4IUJs0LLE/Rs1v9n60+t8GgKhZRaNL0glCHP7AhVR/lf4d+b/HOnQT/rz6U1g16BPYv3iZK7LlreGY9oL9C00ydkXPv1SXT0SlP0GTkSsQzwB79MPrxTzpf/z80OFUg4ta4OO7Br0L7xSDWrIHWDFRfaBiwMBu5D+OYtI5ap0DyfqcjSuRLgfhxv9j6aw1PKVevoh4MdVJTjNz2MxXGT3NqU0xJkqXpSkLn5q+7hiyd+zkcBiWNRVXg8/OGbPuqQMWudJvorQYIFUigO8ALQvqvZbRpCmjqDLc1uXaBzNizZwVskx5ctEVhipxYUs9ZdqE4eMBrolQeMC28keyy5M5FeyFPr27WbL0z8HFKwJEcqDcKayPslJ8zO6wMk7sRaGgz1krr55od4EAlp9RC4chYlbnLuzR4g+Cj81dB7I5xCHLkcoHGJU4aR8P919EkPClLOm5+v5QQMZW1Zgj9YgOpVqjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199018)(122000001)(82960400001)(31686004)(38100700002)(38070700005)(5660300002)(186003)(8936002)(53546011)(2616005)(41300700001)(6506007)(86362001)(6512007)(31696002)(2906002)(8676002)(76116006)(91956017)(316002)(110136005)(66476007)(66446008)(66556008)(64756008)(66946007)(478600001)(83380400001)(36756003)(71200400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkZOUC83bnZETExKL29RT2xEV1d0WUszcHV4a2w3RVVtVHpWNnhCZlhiejlq?=
 =?utf-8?B?Q2xNd1BaRVVVVHNadzRIVVZwMk1zc1lobWl4RE00YjFLK1NxM3J0TWJkNnNu?=
 =?utf-8?B?NW81UWlSSXYzWDdvVEJ5OUZCU0JtZm9VMXZSakFSREJtU005Rkp0cmJCK3NT?=
 =?utf-8?B?RDVmckZEeU5HMVVsZTdjUDN0U05BV21CcmNtUVF4cXlzVEhtT2FTVDUzL3pt?=
 =?utf-8?B?a1N1N1Q5ajY1S2FUL0pUbzZXbmN0ZksvSWdaRjFwcjBtWWtQTXZuRmd6c3hF?=
 =?utf-8?B?c0wyZERsejltRlRBanlkQ0dkRzRtZ3EwNFB0NVJtSEkrdWFhMXZteGNTRUZm?=
 =?utf-8?B?Z0dwWDJ1MnhkY0xVQWpUUTJiY3ZORWdpSTdhdy9RQ1diUEc5TitlVFlXYUtq?=
 =?utf-8?B?ZHAxY1dDTURhNDcxSFJabXVHZFJ4ZlpTd1F6aFlVZlY1bUFVWU9CTkpOSXd0?=
 =?utf-8?B?NngzU1hTczV1Ty9JK09JTm5ZaUJpb3YwSjhKWkRjNklCb3pmOGY1WVg3eDV6?=
 =?utf-8?B?MElYQ1RYWUlqazZLNmxGNG44ajEwNjBSdm5rM1lpT0liZm0xQ1pGb2xCYWs3?=
 =?utf-8?B?MkhkaGxIZzlZdmZBaEVXNVpDUnhkSVdIK0NhWHlDVnpZdlZTREZtdHZlZVhH?=
 =?utf-8?B?T0ZRbjB2dHlSNWdNMU1Dbk9CV2d6UFlmNHd6aTRmQ2VxdG12RCtjRE1DZnBN?=
 =?utf-8?B?VERjTGFwOGk1MGVuSk9xN3ZGNDFObmhHR2hvWlBhUVdaZytUSWlsQVdnemRx?=
 =?utf-8?B?OG9uZDZmSXVvVWZZT1ZDWERoSmJxZ3NYTElwWnkrczBjNkRaQVRaYUtyZENy?=
 =?utf-8?B?ZU00UlVnRU5RSFNRRHVtOU0vV1JmaDFSano0WE5qcUd4Ly9hVVhxTzZjQ3RZ?=
 =?utf-8?B?Yk9tVzloR1BWR3krRjRzSDV4OHBzZFZONWU3Y2dETTl0Y3VNQ2o0Y0JQY0Fn?=
 =?utf-8?B?Smxyb0xYZ1FVZTZ5cFRISlZZRzZyMFNHNlhMb1RJaE01ZmwwWHd0MnhoWkF0?=
 =?utf-8?B?Z0pJcFFndm0ySHhtMkI0YU54WE1hb08vaVp0Q1B3aVlBTHEzZFBpQVlEZUtV?=
 =?utf-8?B?ek5XYmlNSWhwZnZkSTBUWmRISi8zUWYwODcvZUFLZTZZS0VoRnY4WVd5dVEx?=
 =?utf-8?B?dklNVitkb01LR20vb0EvMzNWUUhxN3hBWlZoaWcxd3dQKzIwWHFCeVVNcTBw?=
 =?utf-8?B?RytpS3dwRFRMUFo3RWQwcUlpZzIxVDA1QW1LSWd1ZlJTNUN1c2VkVDhnNGdk?=
 =?utf-8?B?T0s0WFBuZTlzZHNlazdpWWhXOUorZjExYW5nbHhPMHRmV1lMUVJtTGxKV3ZQ?=
 =?utf-8?B?VTU3c25URXVOUzh4RmVlWnNDaE1nNkFPdmJQT2F1MGxGL2cwQXJqeFI1ak5Y?=
 =?utf-8?B?S21YdjRRUDVXc29SZUdRWVVrNWR1dlVSZWZDOENGbVhSczQxWGJQRVBmK1Jh?=
 =?utf-8?B?bmttaS9iWlFuVmxRNThsSitUaHRYQ3Q5eDhTSWROLzZXbENhakF1SFRhU2d6?=
 =?utf-8?B?SzFPTmE4MWFLekcrbXhxOVZiTU1LOFhzSnYzTUg1TlpaUm04ek83YW9oTWRE?=
 =?utf-8?B?Mk5CNDJ6b0orU0N5ZnI2ZXd6NWhGdm5zSVhyaGdPbFJYUm81ZysxRGpITTEv?=
 =?utf-8?B?S2dYY0hzZk1rSWlieG1Jb3hKcmwyTUZZejlyOCtxd3I1ZXQwNWEvVUxPejc0?=
 =?utf-8?B?Y0NibmxKTFB3YjBXSi9hZmttQTdKc1F4QnBudllFejFmRVhhUzRwYkoySGky?=
 =?utf-8?B?NGlkNVZVVmk3c095YWRBSUh0MVZPNnVZaFZhUWJaVnFOenh6SlVuWmJMekcz?=
 =?utf-8?B?Vnp4NTlsQVBpTXkrV0t1emM4NUpHdit1UUZSRU1lM0dLN3dkQjZFdXE1SmR2?=
 =?utf-8?B?bG9DWkdWVW9FckwxM2F5cjMrdXU3S2s0R2pXMDYxRVY0OXNFc3RFU3RtSEFU?=
 =?utf-8?B?YnRjN3VaWXV2Tmg0blZWNXpIT2FVSmtFbkRScVVpbGFLNk91SndQSlU4d1Z3?=
 =?utf-8?B?NUphdUE0L1FvZThSRzhhM2hQeURNL0pZK3A0Z3FJT0o0VFFlYkFqbzF1cEh5?=
 =?utf-8?B?RHFCakhHZkF0OUdsUWloTkxwMzZFUURxeUJteDNJNEphS3prTVorWWJ6Uk9Z?=
 =?utf-8?B?NUo1VE9ieThzK1VnbDdSUTJPWEVlcVJTL3Awb1UxYjY5b1Z1aU1Nbk9UbFVa?=
 =?utf-8?B?Wll4KzdPcEY5Mnd2eFlYbmRNVlBiUG11cGdQU29CSGhaN01nTHRTOEZYRUlz?=
 =?utf-8?B?cUVnbU8wMWY5aURmbk1xVUh6UGJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <562C10AB86D332489C81CB3A349190C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dIl7VTqiODc7kNm0nudkWuHPBx52n6rAc0ufXpNq8TzXxyJ9J9yNjZmD2s8/SED/uhMvCrFzVaNQI3UYC1mxWiQESHMAPDoDjWsN+T3gXGtrpNGZBhWdD+LUsMgoftm29WClicU+KPEX5YyYfZVbTnAXg8uyR/ikm3tphf6LYCDg/6lXYbBIc/ENFHbcvuu4ua57F13zkqZHSAhFZBsdXTdV2MdXwF5goXMOuA0Ig4pfzHIGnVLs/bq0KLMxsaWuYUliBgp9uGXh3nOc6/BN1kTng+Z+BUOj+0kcnLj/R6najsoi379GrmxHGt9dqdXprzj1I9xZoTlS4wHxaedsNGMFASgdqlFgfjbT2AVPidLH9ZsTjYoim/H49j6KKJ7SoyKBTcFx3iJ8Q7pk/I0khHd7Q/LP992RhDWs1i9iouV9GumkEjwCMTxJAJpl6b++HOCurtl2f2KCM99e7jCD1LF2topX7yOEHtSyn8EQE+qmLubkY2tHZxqdEjbSc/d5ZTzMrGsn9chd1GGU67VOe7ELypsz/PESH0ina5o/JZvTANIl3eD+c9QnSoVPVEIhN4iABkPVbIG/qEo9OG+fyhkj74wEgBe1aYjb6Wmlcem4y4k8+5H8YPbTnzwx9OpMPrU/mak2nHN82hE+SmmOehZhCJS5IbYS5zq2/xSLE+SVl89y9uoaSb4QD9Y9lWuFSOZZMBk8tzikADJrp0HBZeFpqepGz3+mMi4gXAhRrGBoOCEbhbdf1u76htrVqy4nIZE045dnwn+xG7VTJi77zXsFgMrPyrMP8/RkkQbEa6BLHRKb7LARUVU3fwPK1923
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 363a9c81-4e30-47ca-6ca0-08db24847581
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 12:05:52.8600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2a+cAVjXVYrC8ENKnVJQfc227v4jRoOXA/nm87eABmT+uf17DCPG4XGfTNKNoKG7gcflmOpkmv/n57BEpLYO20x+mMr0yAPBxWmqHEgzJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0360
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTQuMDMuMjMgMDg6MzYsIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhlcmUgaXMgcmVhbGx5IG5v
IG5lZWQgdG8gZ28gdGhyb3VnaCB0aGUgc3VwZXIgY29tcGxleCBzY3J1Yl9zZWN0b3JzKCkNCj4g
dG8ganVzdCBoYW5kbGUgc3VwZXIgYmxvY2tzLg0KPiANCj4gVGhpcyBwYXRjaCB3aWxsIGludHJv
ZHVjZSBhIGRlZGljYXRlZCBmdW5jdGlvbiAobGVzcyB0aGFuIDUwIGxpbmVzKSB0bw0KPiBoYW5k
bGUgc3VwZXIgYmxvY2sgc2NydWJpbmcuDQo+IA0KPiBUaGlzIG5ldyBmdW5jdGlvbiB3aWxsIGlu
dHJvZHVjZSBhIGJlaGF2aW9yIGNoYW5nZSwgaW5zdGVhZCBvZiB1c2luZyB0aGUNCj4gY29tcGxl
eCBidXQgY29uY3VycmVudCBzY3J1Yl9iaW8gc3lzdGVtLCBoZXJlIHdlIGp1c3QgZ28NCj4gc3Vi
bWl0LWFuZC13YWl0Lg0KPiANCj4gVGhlcmUgaXMgcmVhbGx5IG5vdCBtdWNoIHNlbnNlIHRvIGNh
cmUgdGhlIHBlcmZvcm1hbmNlIG9mIHN1cGVyIGJsb2NrDQo+IHNjcnViYmluZy4gSXQgb25seSBo
YXMgMyBzdXBlciBibG9ja3MgYXQgbW9zdCwgYW5kIHRoZXkgYXJlIGFsbCBzY2F0dGVyZWQNCj4g
YXJvdW5kIHRoZSBkZXZpY2VzIGFscmVhZHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRdSBXZW5y
dW8gPHdxdUBzdXNlLmNvbT4NCj4gLS0tDQo+ICBmcy9idHJmcy9zY3J1Yi5jIHwgNTQgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KPiBpbmRleCAzY2RmNzMyNzdl
N2UuLmU3NjVlYjhiOGJjZiAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc2NydWIuYw0KPiArKysg
Yi9mcy9idHJmcy9zY3J1Yi5jDQo+IEBAIC00MjQzLDE4ICs0MjQzLDU5IEBAIGludCBzY3J1Yl9l
bnVtZXJhdGVfY2h1bmtzKHN0cnVjdCBzY3J1Yl9jdHggKnNjdHgsDQo+ICAJcmV0dXJuIHJldDsN
Cj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBzY3J1Yl9vbmVfc3VwZXIoc3RydWN0IHNjcnViX2N0
eCAqc2N0eCwgc3RydWN0IGJ0cmZzX2RldmljZSAqZGV2LA0KPiArCQkJICAgc3RydWN0IHBhZ2Ug
KnBhZ2UsIHU2NCBwaHlzaWNhbCwgdTY0IGdlbmVyYXRpb24pDQo+ICt7DQo+ICsJc3RydWN0IGJ0
cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzY3R4LT5mc19pbmZvOw0KPiArCXN0cnVjdCBiaW9fdmVj
IGJ2ZWM7DQo+ICsJc3RydWN0IGJpbyBiaW87DQo+ICsJc3RydWN0IGJ0cmZzX3N1cGVyX2Jsb2Nr
ICpzYiA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJYmlvX2lu
aXQoJmJpbywgZGV2LT5iZGV2LCAmYnZlYywgMSwgUkVRX09QX1JFQUQpOw0KPiArCWJpby5iaV9p
dGVyLmJpX3NlY3RvciA9IHBoeXNpY2FsID4+IFNFQ1RPUl9TSElGVDsNCj4gKwliaW9fYWRkX3Bh
Z2UoJmJpbywgcGFnZSwgQlRSRlNfU1VQRVJfSU5GT19TSVpFLCAwKTsNCj4gKwlyZXQgPSBzdWJt
aXRfYmlvX3dhaXQoJmJpbyk7DQo+ICsJYmlvX3VuaW5pdCgmYmlvKTsNCj4gKw0KDQpJIGRvbid0
IHRoaW5rIGJpb191bmluaXQoKSBpcyBuZWVkZWQgaGVyZS4gWW91J3JlIG5vdCBhdHRhY2hpbmcg
YW55IGNncm91cCBpbmZvcm1hdGlvbiwNCmJpbyBpbnRlZ3JpdHkgb3IgY3J5cHRvIGNvbnRleHQg
dG8gaXQuIE9yIGNhbiB0aGF0IGJlIGF0dGFjaGVkIGRvd24gdGhlIHN0YWNrPw0KDQoNCg==
