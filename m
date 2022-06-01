Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB653A157
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 11:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiFAJ44 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 05:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiFAJ4z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 05:56:55 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2056.outbound.protection.outlook.com [40.107.107.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39C26161
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 02:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAN1F4za5jViLkng/gT270W/dVgR1BIlaGKygDF6PYej/yHrf8q7BFk9AH9mvjku12vNOhKx5iqMuJfmGZBLjhr8PfgAo8X/Efe/LGoVQRoMb4rdQPZIWPyYeqGJ1DCHCqVa81XdYBzhQVQonb6L+tkHXVaHrPVbvRinowYXI7NdY3gcfNP2G2LsYSf47I8tbiyvaMSn9+Hzd7jgPL0A1rKT/bHDrgKCSa+ibHqlsn0exUFj17HZOqBpI+FNNRWBECZstxligAutNQ+GqD4Jd6GO00093m3sIdnrW8uR9ksJwsMDqvgaG3aAfLkpYptbWVWa89ICRIWCH/8Xm5xzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVfx8CtHumbtnycd/hbwFbNZrISeDm0S8e4w65dQqow=;
 b=bFe8BxRNfDkyU1SRiVHM+fwpr2qiSaac128QlXSRXah0aX87CkbDMKR7FckUvQuC8njUfpcosdNUQzJ21KcYcy90uBLBsb+RiPNVclojIgCPo1ZFU6RXQSwW/ovEx8yj0DvfMuVbDs9xLgQcRhv7r2IUMkoqKIxFWpg3lqPLVH0KlbLCDl9+tOkFSB5HZe2ypRZKa1BAiYjplLMQbQGkctzmRs5v8mTgI0BwoScPLCbUGis+0/7gzZm0oTO1Vo6B0RXilDzxXggnO41s+4uUczdPDz46WqFfFiG9rWZmv13IqBYoi5RyB+SsM/UPmnEvp7jRSvqh14QOkLgEv3W6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVfx8CtHumbtnycd/hbwFbNZrISeDm0S8e4w65dQqow=;
 b=Cfm+W7yT9Wqm4DZ6BRIkr/6ogEqRA+mCXLPJeiHVOUr02R73T24ipPoCQ+IxhphEKkFkzjANI+8MNkvxdmSojTHsbkWy5X5ziXO/yelwC/pGOxaZQLoioKEVNY5CHJcw/ruxyQztBhhDimyoJX6c27XuWoNAm519f8pBZaYdeRo=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by ME3PR01MB6452.ausprd01.prod.outlook.com (2603:10c6:220:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:56:47 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::1d33:962c:6333:b28d]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::1d33:962c:6333:b28d%7]) with mapi id 15.20.5314.012; Wed, 1 Jun 2022
 09:56:47 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Wang Yugui <wangyugui@e16-tech.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Thread-Topic: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Thread-Index: AQHYdVw+MCjN3L24rUu6KafYRylN8a05z50AgAADZ4CAAAhQAIAAaAwAgAAFh4CAAAUt8A==
Date:   Wed, 1 Jun 2022 09:56:47 +0000
Message-ID: <SYCPR01MB4685030F15634C6C2FEC01369EDF9@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
 <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
In-Reply-To: <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a441eac5-544b-4ea9-2d93-08da43b50a95
x-ms-traffictypediagnostic: ME3PR01MB6452:EE_
x-microsoft-antispam-prvs: <ME3PR01MB64525FE23B54D3A94C287BFD9EDF9@ME3PR01MB6452.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YLsVg7KjMf9W86VvVOInfA8QZU0LbMZvPKyP7phjNkrLezQ7ytIx8l1fzzHj5URZOboOUpoRT62lJ1sqfwjt1rnudV4kdA30S59CTpKOVPQG6XUJAOjxbx6fJTUmh/8xVsZmoatBMIBXxewTKxLChjhiW0NhSnaMzLBc+w/cLrf/qN6di7fP8tobGmn3qjl0F3OPh7zuftJb80Gqxae2jrpuBB5N7OwTO0BbacUW3fvmkt4mEL3bIpKH+aBVCCvmRhDPAQ1pvzyPEXiXzYd/w/wjLCiJbbudhDntqq1BKEFOZRHtHRupM5I5NXhUd3yMdZBMkFiBA90Adjfh1h+jx5bB+l1jG1pqkiRlYfHBoSPTxHL7IuX8pijGZPV+LUXaboR8IuWC0us/kC5FzhizQ1auLmR5EEljIcc84nT4TFkYMFJ1+CIcCtdW1GzKqTT5K8Y/2xf1KS8Sn2wcF6EwjnmMj4Xj0qXT6VJ8YqUpznUSIE6QP/rest1UWZTMZhJGXTb9/9BxbCtdtpXUWy6GB1Ujl82awutBDbvNubrcUAWX54b1LFoCF0HCjtKpR5gv8c7QmXII3H6vooOYKn8SQONnHUx3VPCJopBJxvDCh9AjVsRAcoHUztkjc3kTms3WYScN9vgSgjmgutNG4ExPu3SGBms3s50eO1cQwU7og8FqsLAk8FmMzYPI+AQjSXiC1e1fCFz9qXunD6txI4d78w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(136003)(376002)(39830400003)(366004)(38100700002)(26005)(7696005)(6506007)(83380400001)(52536014)(33656002)(41300700001)(53546011)(5660300002)(55016003)(8936002)(2906002)(8676002)(66556008)(4326008)(66446008)(122000001)(66476007)(64756008)(76116006)(38070700005)(66946007)(71200400001)(508600001)(9686003)(86362001)(186003)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHNpK3VJUzI3QnZrL3J1YXNEWHRFaEFwaStja1M4b0lxWWFvTlBMZSs1T3dq?=
 =?utf-8?B?c21FME4wSk9jSm53ZGxIUi9pbGVWYmRtc3l3NEoxZTFFWXF4ZXJFVWdVc0Yw?=
 =?utf-8?B?TTdOcHhCa0cwYU1QcktNaFVxR3NselhqOHg1WEliMHkzMUE5WC9zR1Y5ZnZU?=
 =?utf-8?B?WTF2TCtoUkVqZUdpdjZQTllxay8yc0U0ZUZEZUJ1RFdQNGV1TGtMOUtQSjFU?=
 =?utf-8?B?bHd1Z3Arb2NXd0NpYXBhZ2dzam53NUJSVkYxSVZjaHJRaDA5UFJNWXRGbklm?=
 =?utf-8?B?RjFsWHZWaUc5UmRDS3VzSHA4ZkV2b0RwQlhFVXkzRDZJUnQzNGJHTDZVTit0?=
 =?utf-8?B?RG1HQmFNem1XaUxwSjRJOUVjdVFXaXRuUS9sKzZjNWVRbFRidU1ja0VlVkhE?=
 =?utf-8?B?T0t1V1VsRzFvVHpUTzhPMkhIQmFOV0VONXJDNFBINUNVOE02aHViT25uTDh4?=
 =?utf-8?B?T2R5eTlJM3ZwMm1NTVVVSE8rS3hkQTNuMjQ0Mkt3aUgxU3NJSGJJN3Zrbm1D?=
 =?utf-8?B?VHA3NFk4bWYvcHFlWEpmaUVxdGU3QjdVanpTODJMallwRWt1Nmw4Uy9SWE0v?=
 =?utf-8?B?emlvd2c5NEF0VDR4NkRreWF0SmdNOTVIcS9BaWt0TFA5azdTWXpRZi9LcjVU?=
 =?utf-8?B?R0JRRmwvakwxaUxyaU5RaUhNNVRwZllRM2k1cEZCdG1EZnZsSHlwdnFCejNJ?=
 =?utf-8?B?UE02MWN1RytUTWM5NTh4YUxveVFqTjhTTnZZSWF3K0xyVFdqUk5ycmROczlE?=
 =?utf-8?B?Q1J1WkVIMjhaTldhZjNDTyttTk5IWmtlbENGcUlmaFRSazJ3MHB4cGQ2WjFy?=
 =?utf-8?B?T28vRDNtMzRMUDd2clZlL2ZTS0oySFV3UzNIL0h5SGRDcXg5Y0N6MUVkbm40?=
 =?utf-8?B?V2Jna2V0WG8vazYzUTlRaW9NWVY3VWFqaUk3cUwyRm5KRXBtVC8xS3hXZ0Q1?=
 =?utf-8?B?bXBLUXEzdzd0eFJGcUlIcHZGdy9XWWNDRjM3KzFDSk1NeHUzNmF5NW5TSGk3?=
 =?utf-8?B?M09yNFkyNFlQbExLTm9Ec3lGTDNIOEh1M2VyV1VRS2VrcEVRcHUrR0M3SGV5?=
 =?utf-8?B?K2FJUi9CTGROY0wzSEk5WGNuenBpZnF4RXVjYUFRSGxvdzdmV25yMVZ2VFNG?=
 =?utf-8?B?TUY1UFpnNDJnUHUxM3lncjdScWhwamJRMzlEaFFyTnBTK05OZVA1Wmo3c0Vh?=
 =?utf-8?B?YjgvZUpQUmMzM0RKYW44NGkvNGpzaDRsYkR4NGN5T05ZUExoc0dzRGZTMVE4?=
 =?utf-8?B?SGM4Y3JIbUVKblJ0cHlnbjZkT0dURjQ0andWMTdzT1liait3Z1ZWd1dNSmVy?=
 =?utf-8?B?S2Iya2dNcGFCOCtNSTl1Sk91dEZwYkR0OHdoWlArTUxjRDJQbXB3SC96ejBD?=
 =?utf-8?B?cTlTdlFGeWw5RjBzN21YbitqS2REcmxzTW1TbHhuTmRHUkNaeWNuUDE5NzRP?=
 =?utf-8?B?NDNkRS8wUHArdTkvZHhZTW1IOVBQTGhCSEVKeE0rN2xDbmtra1F4VzJIeFh3?=
 =?utf-8?B?QjBjT0NYS2FaN1pjMmxkK3ZjUFR1WlJGdHFSV2Q0Q251QjBMeVJZNFhNOW50?=
 =?utf-8?B?MkNqa3FXSFRWVitnZlR5VWM1R2NLSlJaT05Za3YzVE9xVVJyYitjSE9PSEli?=
 =?utf-8?B?ZCt4U3pCYzBLeGRib1Z3TXd5V0UyL010Umk4cXVmK3FUM1AzSWtHdlg5dDZV?=
 =?utf-8?B?M0VSWm52ZjVOZEhlT1RqSlpGMUREK1ZkSmp0S3RKalFudCtURWdFdXZHVEJQ?=
 =?utf-8?B?NmZtcTNWTUJFTEN5aDM0eWNERG9BaXBtaEFyZmFTSVNTbWN3cm1xT0RXbTc5?=
 =?utf-8?B?eWQ5MUc2eW1Qak5YSGtSSXJHakxHcldQaGRLL1FhbDF3RHVTS2VSbWtwRHB0?=
 =?utf-8?B?eXk4bFhBOFBmcHlCNlV2bDBjMWNaYzR2MVlsOHh0QTJUUG52aURkd1MxcEVQ?=
 =?utf-8?B?VmdielMvWVNFOWl5WWdRQUI1UDNJeG1BUUhGeDZCZnlsRVlGMkh5OG5oSzIr?=
 =?utf-8?B?bkJhT3BsY2FvZkJhMXFpUFFSMy91MmFFYmUxYWI2cFR4bm5wbzBSbEVkdHla?=
 =?utf-8?B?dDVZV2wvaUk4Z2c3VmFGd3Y5aVpveEV2WjFlTVZVa0dVTFRvMTgyUHhZRGdD?=
 =?utf-8?B?TW94NjRnWEJGNnYxczhoaDhYeEs5R1ZhWlgyQ3o1N21tYzVsdEtPTzBMajNU?=
 =?utf-8?B?ZlJ3ZmVTOTl0dXVlTSsvbnlCeVE1dHB1UHQ4R0VNTWtDTy9Bc3hnTWQyekln?=
 =?utf-8?B?K3ZrcFN2KzB4TEhJK25GUDJnL2huZzdHQWZyaVg4bXFuK1ZEazNxaDR3bWxJ?=
 =?utf-8?B?Ym4rTGZDWnR5emxVcGg2VFpGaEVmUTNMOWdkejBUbytqTjY3L3ZEZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a441eac5-544b-4ea9-2d93-08da43b50a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 09:56:47.1880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lfLaVRMNt2hhIdUUFf8MlqyPTGWCb211l4iQMRg7188Keqw7d9m+rp4x+M/ktgfQajR01MXX73qtD+LUHIZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB6452
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFF1IFdlbnJ1byA8cXV3ZW5y
dW8uYnRyZnNAZ214LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxIEp1bmUgMjAyMiA3OjI3IFBN
DQo+IFRvOiBXYW5nIFl1Z3VpIDx3YW5neXVndWlAZTE2LXRlY2guY29tPg0KPiBDYzogbGludXgt
YnRyZnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggRFJBRlRdIGJ0cmZz
OiBSQUlENTZKIGpvdXJuYWwgb24tZGlzayBmb3JtYXQgZHJhZnQNCj4gDQo+IA0KDQo+ID4+PiBJ
ZiB3ZSBzYXZlIGpvdXJuYWwgb24gZXZlcnkgUkFJRDU2IEhERCwgaXQgd2lsbCBhbHdheXMgYmUg
dmVyeSBzbG93LA0KPiA+Pj4gYmVjYXVzZSBqb3VybmFsIGRhdGEgaXMgaW4gYSBkaWZmZXJlbnQg
cGxhY2UgdGhhbiBub3JtYWwgZGF0YSwgc28NCj4gPj4+IEhERCBzZWVrIGlzIGFsd2F5cyBoYXBw
ZW4/DQo+ID4+Pg0KPiA+Pj4gSWYgd2Ugc2F2ZSBqb3VybmFsIG9uIGEgZGV2aWNlIGp1c3QgbGlr
ZSAnbWtlMmZzIC1PIGpvdXJuYWxfZGV2JyBvcg0KPiA+Pj4gJ21rZnMueGZzIC1sIGxvZ2Rldics
IHRoZW4gdGhpcyBkZXZpY2UganVzdCB3b3JrcyBsaWtlIE5WRElNTT8gIFdlDQo+ID4+PiBtYXkg
bm90IG5lZWQNCj4gPj4+IFJBSUQ1Ni9SQUlEMSBmb3Igam91cm5hbCBkYXRhLg0KPiA+Pg0KPiA+
PiBUaGF0IGRldmljZSBpcyB0aGUgc2luZ2xlIHBvaW50IG9mIGZhaWx1cmUuIFlvdSBsb3N0IHRo
YXQgZGV2aWNlLA0KPiA+PiB3cml0ZSBob2xlIGNvbWUgYWdhaW4uDQo+ID4NCj4gPiBUaGUgSFcg
UkFJRCBjYXJkIGhhdmUgJ3NpbmdsZSBwb2ludCBvZiBmYWlsdXJlJyAgdG9vLCBzdWNoIGFzIHRo
ZQ0KPiA+IE5WRElNTSBpbnNpZGUgSFcgUkFJRCBjYXJkLg0KPiA+DQo+ID4gYnV0ICBwb3dlci1s
b3N0IGZyZXF1ZW5jeSA+IGhkZCBmYWlsdXJlIGZyZXF1ZW5jeSAgPiBOVkRJTU0vc3NkDQo+ID4g
ZmFpbHVyZSBmcmVxdWVuY3kNCj4gDQo+IEl0J3MgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCBsZXZl
bC4NCj4gDQo+IEZvciBidHJmcyBSQUlELCB3ZSBoYXZlIG5vIHNwZWNpYWwgdHJlYXQgZm9yIGFu
eSBkaXNrLg0KPiBBbmQgb3VyIFJBSUQgaXMgZm9jdXNpbmcgb24gZW5zdXJpbmcgZGV2aWNlIHRv
bGVyYW5jZS4NCj4gDQo+IEluIHlvdXIgUkFJRCBjYXJkIGNhc2UsIGluZGVlZCB0aGUgZmFpbHVy
ZSByYXRlIG9mIHRoZSBjYXJkIGlzIG11Y2ggbG93ZXIuDQo+IEluIGpvdXJuYWwgZGV2aWNlIGNh
c2UsIGhvdyBkbyB5b3UgZW5zdXJlIGl0J3Mgc3RpbGwgdHJ1ZSB0aGF0IHRoZSBqb3VybmFsIGRl
dmljZQ0KPiBtaXNzaW5nIHBvc3NpYmlsaXR5IGlzIHdheSBsb3dlciB0aGFuIGFsbCB0aGUgb3Ro
ZXIgZGV2aWNlcz8NCj4gDQo+IFNvIHRoaXMgZG9lc24ndCBtYWtlIHNlbnNlLCB1bmxlc3MgeW91
IGludHJvZHVjZSB0aGUgam91cm5hbCB0byBzb21ldGhpbmcNCj4gZGVmaW5pdGVseSBub3QgYSBy
ZWd1bGFyIGRpc2suDQo+IA0KPiBJIGRvbid0IGJlbGlldmUgdGhpcyBiZW5lZml0IG1vc3QgdXNl
cnMuDQo+IEp1c3QgY29uc2lkZXIgaG93IG1hbnkgcmVndWxhciBwZW9wbGUgdXNlIGRlZGljYXRl
ZCBqb3VybmFsIGRldmljZSBmb3INCj4gWEZTL0VYVDQgdXBvbiBtZC9kbSBSQUlENTYuDQoNCkEg
Z29vZCBzb2xpZCBzdGF0ZSBkcml2ZSBzaG91bGQgYmUgZmFyIGxlc3MgZXJyb3IgcHJvbmUgdGhh
biBzcGlubmluZyBkcml2ZXMsIHNvIHdvdWxkIGJlIGEgZ29vZCBjYW5kaWRhdGUuIE5vdCBwZXJm
ZWN0LCBidXQgYmV0dGVyLg0KDQpBcyBhbiBlbmQgdXNlciBJIHRoaW5rIGZvY3VzaW5nIG9uIHN0
YWJpbGl0eSBhbmQgcmVjb3ZlcnkgdG9vbHMgaXMgYSBiZXR0ZXIgdXNlIG9mIHRpbWUgdGhhbiBm
aXhpbmcgdGhlIHdyaXRlIGhvbGUsIGFzIEkgd291bGRuJ3QgZXZlbiBjb25zaWRlciB1c2luZyBS
YWlkNTYgaW4gaXQncyBjdXJyZW50IHN0YXRlLiBUaGUgd3JpdGUgaG9sZSBwcm9ibGVtIGNhbiBi
ZSBhbGxldmlhdGVkIGJ5IGEgVVBTIGFuZCBub3QgdXNpbmcgUmFpZDU2IGZvciBhIGJ1c3kgd3Jp
dGUgbG9hZC4gSXQncyBzdGlsbCBnb29kIHRvIGJyYWluc3Rvcm0gdGhlIGlzc3VlIHRob3VnaCwg
YXMgaXQgd2lsbCBuZWVkIHNvbHZpbmcgZXZlbnR1YWxseS4NCg0KUGF1bC4NCg==
