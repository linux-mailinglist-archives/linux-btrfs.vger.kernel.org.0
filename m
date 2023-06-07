Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA031725BB4
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjFGKiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjFGKiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:38:16 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F371BDA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:38:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXVoWJFBIRzw5fyr9NCJji0OfOf3MU1PXNgJVzZoCVkKhptPhU8tG/KqSGsqpqt5n4pRWMtratYTxBg9Po2aonimefFzeUyXNqHz25SUKzPSM4+ssmyHae0yVZWaoHG5+GHGd/ENlWQBemEcMru0e4g+YtHQvUe73ONDfkiEaveZnKafxrb47lURAQCSGaNikSWYuMZI1+zqGa4R3DgJYB8VZLNi8U6R/NR5r3Cv+Gr4xBuqnrr0pheYzmQ1wam2WmZqhNxmX9M5Go0Lxs+kdBjxLKCInENk4NElvmaVY3TGwYhya16XcjF8chf59dckU9mT8mkJu6W4s31mpQogKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtkAPVC3GZtxEcGNzry3bbWKz51ZK4qlLQ5plkRtN+E=;
 b=n18FR9qInSowMlMa9hP1tMsIfI9zuiplp1BcAOa0w8fh9fGt224ihXoQSP754VjGJkqnTtb6t/rw+ZF31KPnScZmsJdFJsQ1DmUXhHtF/G0aQTId7NS4N0K+u5MmlKquvGRxruv20LuVGprVeTSpIyoezpOwpkfXGUjxr8zpAHfkLA1HcmAGl6XS+/Us2XoR9i0UufyIMkluN6PNzwM0cNLq3vIRLTyjZLmOy10i8GD5B7a7+L68ELlpk/6Wb7Y3ZcwnO/4xyKvcRWvPu3NXSpaQd7KR993wCLdWCqARe5gvqOmIj5Gpl9qPgDIj69ExMvxBOr5iLGR6KmNQLq7ZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtkAPVC3GZtxEcGNzry3bbWKz51ZK4qlLQ5plkRtN+E=;
 b=imEuSM1oKumwAo2PneB9HD1oHaR/d6p0aLSqOlx7dU5OqJl+njPc7MTseCuzKDWCVmk4O0NGRhT1g/RVHW/Evws/DFtrUWbaAjIwuuGypFF/E0709vTPfFXLATQVMLoVWOmX2V+oZZe8/Y7tBbDLYvTOTrgUh7+EMR3/FVgZR/w=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 10:38:08 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:38:08 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAyVbEA=
Date:   Wed, 7 Jun 2023 10:38:08 +0000
Message-ID: <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
In-Reply-To: <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|DU2PR04MB8904:EE_
x-ms-office365-filtering-correlation-id: a909d5d3-e832-4425-e4e0-08db674348e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4yC3AHaRnPnB9ewmpiVbYl8zO9X1trzpM3TNNbJEEWkbr+5In2b6blR9hn3NVuGktFSFO9OeNRzALjk3YsFEs1k1GQ/cqXuSX5REdeN6Is2bkZlXxZ6JhRpzq+YwfKKKKiNdv1jj2pbSNph1Dz13MHOmTJwst0kIPB6hf6bXmLB825/q+OZjOO3ltvzDq0vMCBd0YAuGffPdtu+Q2YzEjTJ3vGS4wrMvcfENW7BZmN8MpH7JuV8UgcKrrirTtB1qZxFhBN1Nv4goYHu25jbKNx1JsFJkkLN2fer1ZexmSIufdjcrXjGuc6mOOdThTQ/L5E+PRktPLxTmNnJyhUz3g4wu3tOPrBWIl7/f4UpbikzplAF4gO6FdWiwUkaKR/7apYM1qKcSBQsxRTLZnAI7wLPJkKx2FpTuNx39dAhuKr4dlZa0/AIRy1BxpfO8pAOJpRoHLE8BG7fYehBdooEi+mklob+TujLmmrzfMLxM4AWSxKmyAmM67UiVbRXHs7pLa6zeGz3S2wTxUqe1Gi96ofZeY1UVHmQSxgAK1PIXlT4nHtGjPTnVERA5LWOxGGZiMFc3VxGe2nexx112gRIyQ2xQjG5+ddBrTrC9eiRDhLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39850400004)(451199021)(66946007)(8676002)(66556008)(76116006)(16799955002)(966005)(86362001)(7696005)(8936002)(64756008)(66476007)(66446008)(316002)(41300700001)(52536014)(44832011)(5660300002)(478600001)(2906002)(33656002)(71200400001)(110136005)(55016003)(186003)(38070700005)(38100700002)(122000001)(66574015)(3480700007)(83380400001)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjU2NGJvS3JISDBCVHFnWURxY1JhcXNmNkN2OTRVTU00YzVWenFGb2hCdThF?=
 =?utf-8?B?clRDTnRNSG5QRzVXZGFuRm1LSWJPa1N6ZjFrUTlaQldzaU4zZzlZZ1ZFOWJK?=
 =?utf-8?B?alVGbzhFU3BJRlpieElreGpyakdKQXV4WnRnelk4QWcvMjJVeDBlZSs0M3RW?=
 =?utf-8?B?TlEyZ1NBOTNBMlVXdFJUYnAwU2hjLzhBK25lNitmRzV2NVpQZ3ppWkJQUVg2?=
 =?utf-8?B?eTV5YmNlZHg4L1FMWU1KTWZqSkMxaUUwejZTcFh0WUhYOXVFYkVVa3E0c3pq?=
 =?utf-8?B?bkN5TlllOGFmdE9jZHRxalR3RXRZMzFsbUxHZ1FnS1BOckt1bDlXTTUyb0JX?=
 =?utf-8?B?UWpySWJYRVdzdEgwc0U0VjRUTGFaVi80a2IzQ0l1eURFaEdlZmJqNHpsWTd2?=
 =?utf-8?B?OFNrd3RqMnB2UFc0QmdSQTZqTDRrUlFRb3RZTFNob3V0V3NtOXZCbnFnN0lX?=
 =?utf-8?B?bHZYZm00a3BBT2N4ZVhaNHhjaW9xOStiNWVqdDFqSDZDV0xqN25GS1JtWkVy?=
 =?utf-8?B?b1djUzNhOUJrcmVJaGVoVE82b2QrOGpCNlJZcmcxL0tJYXFKUUdNZFhIMlc0?=
 =?utf-8?B?aFhhR3RpV2wzRW1Hb1k4SXYzTjQrZVJtL2M2OVJnRnVyWGkyK1BNaUhYOVFq?=
 =?utf-8?B?UXVNRHZxMCtNaWlleE9jMmFMei91ZDBqVmdZUnRwanhKY3Y5bExUdzN5OEh5?=
 =?utf-8?B?bUwvUWgvZUkxd2dSbG5qd3BRQXpwWlhPOHd1MS9rUVlkMU1OQlJnMUwwQUt6?=
 =?utf-8?B?TXJ4OE54cjRPdkZLT3lzWXc0d2oyOFBRdTdDSGVsM3QrR3FPYmhFTmQwNk1y?=
 =?utf-8?B?em5idWw1eVhZMUU5V3RvOG5lb2w5cU9SbGhyR1dHYXZmTW41WnN3bmlRRldq?=
 =?utf-8?B?NzJlcWY2d1ArNVljQmh5cy9ELzFhNjZNZ1I5a1VIWllUMVo5TFFuOVM3QkFv?=
 =?utf-8?B?MzlVVm01dGdrbldyQTdCZmVkcUR1bkk0b1FBb3VSWUhyQ1VZTjhvN2ptSnJK?=
 =?utf-8?B?a2I5elh6MmN2RDVQZ3F1K1BtZjNmU2ZtcnZiOVFtQ3o1TkJ0QVRyOGR5R201?=
 =?utf-8?B?ZjRENnZKWnVaYU1VQWdZRUpicU5xRlZ5bTFUbE1yWDArZ3NNKzdsWXU2azNU?=
 =?utf-8?B?aHBFeGFFS2EvTFU4bWNXWWVlRmk4ZkhyRnAwWjlQMDJzMTZXNGJOdVNuQ05l?=
 =?utf-8?B?N1pHckQzUTlkSHdVODlGdEVVb3Rtem1vck1IdnVvOXpIcTBiRWF2WjBKd1dX?=
 =?utf-8?B?YUVuMm1TWUZEUFhOS3BPVzhKUDVEdURrL1dsTkhEa0tZN25BWGRSZExxS1pF?=
 =?utf-8?B?L0FLNWxEaVNzRWNQS3BtaTZoTFA1ZHpKMFR3WkFVaDNMQ0dkVGhBNzg1QVor?=
 =?utf-8?B?UUtpVVlYeUFoZmpEVVZNOXFwS2JRcTBFQTlOS3Yxem9WVlNpU2Fib1kxdTFz?=
 =?utf-8?B?dVZab0MwQlVYWUxIeDR4aUtDVVdES1kzZVdhUnk1Zk1tZDJhVWRGbjF0cjI2?=
 =?utf-8?B?ZHZJaGFqdTFKSG9odGw5dis5ck1kS1ptTy9EZndKMURYMHlEY1hOQ2FGVmo5?=
 =?utf-8?B?QmVvSlhqaVFEQ0YrekM0ZEZIWkxLUkJVdkxuSmovLzl6aGgxN2dUVnhwaTl6?=
 =?utf-8?B?Tzk1cGdxSjFsV0FFMGM1SFBkQmFRcXBQaDI1cEQ5T3ZNY2pyZkMrdVlNS3hU?=
 =?utf-8?B?bzZSWkxJdC84VktmTDVSbDFWRmJsTXhLV3Izai9ZVFprUzBISSsvVk9RbGpu?=
 =?utf-8?B?VmpRdlFNditmWFlqU3FhMFpnRTFEalp2U25tQklCYTlqR0RRczROVW5Lc00r?=
 =?utf-8?B?cGRwSVRmNjAvUW1MZTA5OGcyaGhJUDVtalRrUEhhempMaGxNQzVLNEhFV1Jx?=
 =?utf-8?B?Sm1SZ3ZqemJHcTVyMDYyVy9KOEdLREU2RTlLVkg0U2ZXaTEvN3RVVVZCT2tx?=
 =?utf-8?B?aTB5bkFzeWp6bmo3ZXVRc1RucXljQzVDVTh2M1FmRDhZOGkrZHdydVBDbW1o?=
 =?utf-8?B?SWczNGtGT0JDU1hWNHVmd01Cc1N3U0R0Z2NWWmFDUnE5M1BLa0JGakZKL2ZF?=
 =?utf-8?B?STFoZ0YydTdveFVMTEJHTXpvb3RpUFJTczY1Q1hVUHl5K09IZkhiV2djSmY1?=
 =?utf-8?B?OWp1cElDUFRZa0RBZVh6WXUrZmFJTGxqWXpuS0lSQWhLbDFobUxKSTJET3FW?=
 =?utf-8?B?RzJPSEJNVEtRWWF5MVlDSm5XbGlLQ2dsUG5xN1RzODc1eExpV09qaXRVd1Bi?=
 =?utf-8?Q?j4DwCIqUlNdYH8kAFsJJnriw6OcZJZHA192qGRUjSY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a909d5d3-e832-4425-e4e0-08db674348e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 10:38:08.6212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGlyLB4kaBdixDrOEe04KLpKrK/mRD2ccBrvqX+mYXtDA3ZmM9FtB3fRTWuZrNvXmaueqs1H7p4uYwo+0iBQBtkXa6uA2P5fwzqA8X6nplB2APq+X7EbTP4ujtqvCz5J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RGVhciBBbmRyZWksDQoNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQW5k
cmVpIEJvcnplbmtvdiA8YXJ2aWRqYWFyQGdtYWlsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIEp1
bmUgNywgMjAyMyA2OjM3IEFNDQo+VG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1o
b2x0ei1tdWVuY2hlbi5kZT47IGxpbnV4LQ0KPmJ0cmZzQHZnZXIua2VybmVsLm9yZw0KPlN1Ympl
Y3Q6IFJlOiByb2xsYmFjayB0byBhIHNuYXBzaG90DQo+DQo+WW91IGNhbm5vdCByZW5hbWUgb3Ig
bW92ZSBiZWNhdXNlIHlvdSBjYW5ub3QgInJlbmFtZSIgb3IgIm1vdmUiDQo+c3Vidm9sdW1lIHRv
IGJlY29tZSBmaWxlc3lzdGVtIHRvcCBsZXZlbC4gV2hpY2ggaXMgb25lIHJlYXNvbiB3aHkgeW91
DQo+c2hvdWxkIG5ldmVyIHVzZSBidHJmcyB0b3AgbGV2ZWwgc3Vidm9sdW1lIGlmIHlvdSBwbGFu
IHRvIHVzZSBzbmFwc2hvdHMgYW5kIGJlDQo+YWJsZSB0byByZXZlcnQuIEFjdHVhbGx5IHlvdSBz
aG91bGQgcHJvYmFibHkgbmV2ZXIgdXNlIGJ0cmZzIHRvcCBsZXZlbA0KPnN1YnZvbHVtZSBleGNl
cHQgYXMgY29udGFpbmVyIGZvciBvdGhlciBzdWJ2b2x1bWVzLiBQZXJpb2QuDQoNCkNvdWxkIHlv
dSBwcm9wb3NlIGEgc2V0dXAgaGVyZSB3aGljaCBkb2VzIG5vdCB1c2UgdG9wIGxldmVsIHN1YnZv
bHVtZXMgPw0KSSBmb3VuZCBpdCB2ZXJ5IGZydXN0cmF0aW5nIHRoYXQgZXZlcnlvbmUgc2F5cyAi
QlRSRlMgaXMgZ3JlYXQsIHlvdSBjYW4gZG8gc25hcHNob3RzIGFuZCBlYXNpbHkgcm9sbGJhY2si
Lg0KQmVjYXVzZSBpbiByZWFsaXR5IHJvbGxiYWNrIGlzIG5vdCBlYXN5LiBIb3cgY2FuIGkgYXZv
aWQgdG8gdXNlIHRvcCBsZXZlbCBzdWJ2b2x1bWVzID8NCkkgaGF2ZSBzb21lIFN1c2UgYm94ZXMg
d2hpY2ggc2VlbSB0byBoYXZlIGEgY29ycmVjdCBkZWZhdWx0IHNldHVwLiBCdXQgd2hlbiBpIGlu
c3RhbGwgZS5nLiBhbiBVYnVudHUgYm94DQppIHJlYWxseSBkb24ndCBrbm93IGhvdyB0byBzZXR1
cCBCVFJGUyBtYW51YWxseS4NClRoZXJlIHdhcyBhIGdyZWF0IFdpa2kgKGh0dHBzOi8vYXJjaGl2
ZS5rZXJuZWwub3JnL29sZHdpa2kvYnRyZnMud2lraS5rZXJuZWwub3JnL2luZGV4LnBocC9NYWlu
X1BhZ2UuaHRtbCksDQpidXQgbm93IGl0J3Mgb3V0ZGF0ZWQuIElzIHRoZXJlIHNvbWV0aGluZyBu
ZXcgPw0KDQo+WW91IGNvdWxkIHNpbXBseSByc3luYyBmcm9tIHNuYXBzaG90IHRvIHJldmVydCB0
aGUgY29udGVudCBvZiB5b3VyIHJvb3QuDQo+SXQgd291bGQgYmUgdGhlIG1vc3Qgc2ltcGxlIHdh
eSAoaXQgd2lsbCBwcm9iYWJseSBpbmNyZWFzZSBzcGFjZSBjb25zdW1wdGlvbg0KPnNsaWdodGx5
KS4gT3IgeW91IGNvdWxkIGJvb3QgbGludXggd2l0aCBzdWJ2b2w9Li4uIHJvb3RmcyBvcHRpb24g
LSB0aGVyZSBpcyBubw0KPm5lZWQgdG8gYWN0dWFsbHkgY2hhbmdlIGRlZmF1bHQgc3Vidm9sdW1l
Lg0KPg0KPklmIHlvdSBjaG9zZSAidXNlIGRpZmZlcmVudCBzdWJ2b2x1bWUgYXMgcm9vdCIgcm91
dGUsIGtlZXAgaW4gbWluZCB0aGF0DQo+DQo+LSB5b3Ugd2lsbCBsaWtlbHkgbmVlZCB0byByZWlu
c3RhbGwgYm9vdGxvYWRlciBiZWNhdXNlIHBhdGhzIHdpbGwgY2hhbmdlLg0KPg0KPi0gYW55IHN1
YnZvbHVtZSBiZWxvdyAvIGxpa2UgLy5zbmFwc2hvdHMgd2lsbCBiZSBpbnZpc2libGUgZnJvbSB5
b3VyIGJvb3RlZA0KPnN5c3RlbSBhbmQgeW91IHdpbGwgbmVlZCB0byBleHBsaWNpdGx5IG1vdW50
IGl0IGlmIHlvdSBuZWVkIHRvIGFjY2VzcyBpdHMNCj5jb250ZW50Lg0KPg0KPi0gYXMgbWVudGlv
bmVkIGFscmVhZHksIGRvIG5vdCBmbGlwIHJlYWQtb25seSBzbmFwc2hvdCB0byByZWFkLXdyaXRl
LCByYXRoZXINCj5jcmVhdGUgbmV3IHdyaXRhYmxlIGNsb25lLg0KDQpXaHkgbm90ID8NCg0KQmVy
bmQNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3JzY2h1bmdz
emVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TDpGR0ZXIg
TGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxtaG9sdHot
bXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBoLmMuIE1h
dHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNyYXRzdm9y
c2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xpbmcNClJl
Z2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3QtSWROci4g
REUgMTI5NTIxNjcxDQo=
