Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99269CA5E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 12:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjBTL6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 06:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBTL6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 06:58:51 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3BB472
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 03:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676894330; x=1708430330;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=BalJq6gqgXdqQJSCzbcYq6wH8XADrATki3oRr/ba+nQSqJyXhL27KW7p
   14wt50SRogVL+hJkq3GF37iNjnNvxqTVOMn0Blk/ARbnN4+YiJHc7zoZG
   LOmW5f4ommeP80Yv5tAyCImbHQeZ6F8ipFgL+3J+8X5l9mJrwAmY+W5m4
   05p4QxJrnTKFup8omY5k0UTcY1yKkZANvBYrSdWxE4KwpoNUCmRH6vodm
   zyqXi17dwsS8XMTOaoBvbx9dRqA1V5Ylw+NOkOPQfavu8wjGhcyF7RZOs
   DHr4QGMCnu1ilIxxHi4kv1uhYTMIog21NGpLLJDMZ7jtdJ+sfh0qfbxuX
   w==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="228699876"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 19:58:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYU6keteWW5oxzCC98ngLZVcvK/xXNR9FtbDKn3kdp+NHIF5Invq2RP2dwRcu5ECeMvRgghxk0Dn9QS6P9fSsUhF9/ktByMBAWNcvzE+/nirYsbZB6JNbDirbjA1HzNDi87rIuZ+QgPWA8rXrtjBAG6HvCJKnzHXSQq6sMob7fzdj9RYgOq65QoktY7aUJ7s7OKeAB6D9D4fxcWH1t167xeAn8CBesFVhc+bLmsefNwmneOAhbSZtD5nuAc0psIunK5vv5vFqEFbeniNNfNP5KxmTsHwzDBv7/XE7bSEhJoK60XsWCCQYbZ+84G78v/63jUdtWuCjqOQYx+Lv+gx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=lhxw8zbiOFNRthVRCIFRqvXvIJNNj2bRz+Mnfycvbap6D7osRZjzocTVxvNT+mvxZrS2/mkW6sITjbj/7rMq2NO4XtpIJonFIiMMp2FvKPVB9ymc4752+hLSxHaf5GXbucEE0wg+8McOFyJj52yILSq0XmANW4zJEn8rhDKHPTPZLV9ju1iyeZjdTzmS8IrTV1gE6Q4J8juAFt3VYgE2wr3ZtYm6zzXDjnvW3TWB8lQ9XITOPCsmmjJTtNsEuHxFDBazWOypYg/qTbKiAYW4Z/hk+9lkOAGC4CdRoL6otZERA/umgh1w7LTDyEoxbXOj/cHhtUwvQ3GFEYdtN5vBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ehANBoFqS9DLHIMbdjs8n6Zj1fpWYXstY2nGYcTdRXmd9I5UPo00LC3suKmX4lIbDB9M5sNDrbdcnwpHhiYe7mZz++dLO+chynqXaEav2hovtMZRqpN/6WJ7kYQmxAXPhNBozP+vrU1b8eevBkNRcuw7Ez5SPZvsLQWaiZqfCdg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7524.namprd04.prod.outlook.com (2603:10b6:303:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 11:58:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 11:58:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 08/12] btrfs: remove the compress_type argument to
 submit_extent_page
Thread-Topic: [PATCH 08/12] btrfs: remove the compress_type argument to
 submit_extent_page
Thread-Index: AQHZQiSrktT54X/GdUaFB7lsdCtQI67XwRSA
Date:   Mon, 20 Feb 2023 11:58:46 +0000
Message-ID: <158f9118-944e-3faf-0f94-7217f671048d@wdc.com>
References: <20230216163437.2370948-1-hch@lst.de>
 <20230216163437.2370948-9-hch@lst.de>
In-Reply-To: <20230216163437.2370948-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7524:EE_
x-ms-office365-filtering-correlation-id: 87962c96-3e48-49fa-0ab1-08db1339d221
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eTv4VkQn8EE3T9ZoAx4AiV3ji7wj5RRQnmttb9qzMkVfIyGLRs8AxNwZCQu66c3geh0Tpxo6y6mzkEiyhNb4UYyNfiBmrhIwa2tqt9kk2ph9pCXpYGQ4EMv8sdb8aaLdUqAOvSsowje37QuRR1UTHWorw/jjAJc6RNS5OqA4MxcOjrmkIF/Z/BBo0kYCBB7pl7D2ggKN4B63Re4DgspfmPW8b6ai11bqfv3xdD6Af878PYc3CvHf7HxIngZTw0ctjO/Ln2CGW/Og++NITjjUADsdjzk2LiEosOC8XYZ/h+2O23eATITP/mVfLlrYY8sQoRIHJvVa1p4hwuWZCyRweByXZZ0lHC3FXHUKsJGaZbALmqGwyrWZ69t1i2XLmShXRx6Vq1VLt230QSkodyW2cIErTfVaNTzee9prkqnKDrW26fGH2qggOsYiDGZdtNtK/k77fFMzFR/Cuyl9rqikyBMDg/Qszma0gTfPmL0GI6lc6A4SafH6+SLuhrPf+OaKbVap4AIe6Jcx3s9oLCWZ4AXbrCnmCP5gBIJvcDGOXjo6yL461mYi4Y6tXrCGb/IBSvm0oraF/e7w1kTyphRR/jLaqOOTLK7h2mi/7xbJyVkVyryMbGX8nMbVSxyRGknSAfzcrKMic6dUthadtpPO1owUV8bOaOPHkfsnY/dXtVBp/eewWIMNOT1Ovdd0CIWYuwg+aQHsTIcu3UDVsVO8ny/sSpUT6qr+kZXOQzObAodEk42RDEDrjmGPROi2Y3dIjaTaJ2S27PDbAkGcuRY7hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199018)(82960400001)(38070700005)(122000001)(38100700002)(558084003)(31696002)(86362001)(36756003)(66476007)(5660300002)(19618925003)(8936002)(2906002)(66446008)(4326008)(8676002)(66556008)(91956017)(66946007)(76116006)(64756008)(41300700001)(186003)(2616005)(26005)(6512007)(4270600006)(71200400001)(316002)(110136005)(6486002)(478600001)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG9aaTMrMkt0NTJ4cysyMHZZei84RWdFN1V5OE1ja0Fjdmdjdlk0eVhIRTRh?=
 =?utf-8?B?b25qQWh1bWZhL2xZSWVQZEJSZCttUlM1Mk84MWg3RnVHQ3dqN21MVG1LL3Yz?=
 =?utf-8?B?UXJ0d2xFdXFJcFAyc2RtODdqSEZYQ1lTSXZZVE43SUdzR0k3NGFKTEdqaUNq?=
 =?utf-8?B?MGkvZWxyQlMzUFFFVE9qeTFRcCtNSUxvS282SlMzbnpZQVVncDUrd0x6cWd3?=
 =?utf-8?B?THRVbnJteEdFZUJxZ0thTTRWZ2RueHlQTmQ5bTlmRTB0OFFmT1BDemZXclR1?=
 =?utf-8?B?YmZ4NEZYNEJ5QjV3eVcvU2hyNHBiSDkzaEdFZFA1WkljNjArU1l5R2dkN0hJ?=
 =?utf-8?B?ZXJCU2Uyb25hdS9JeVJaTXRxRis5dmtKYXplRFpobUwydmhqczJuTEZUTjRr?=
 =?utf-8?B?a3JYSytVZXhHdk5VNitraW1zQXBjOVJrOE5RQjZaTHJNWDd1Z2Q3TThDS3Z1?=
 =?utf-8?B?R2ZEU3ZnMkNuT3pOVEF3VFRlRTllcndtK0pTQndaQ0ZSb0F0MitabUp3dGht?=
 =?utf-8?B?SFdSaXA5Ymt1QzlFS0RCMlZHWXIxenR5bTdERjJFdmRKNXVRS0NKN2FSUC9h?=
 =?utf-8?B?Q1daYUJzbEdoK05yaTFWK3A5U3h1cVd0NzZ3cS9rcmN1aFFJWjByTlpJdEpp?=
 =?utf-8?B?VkJxRzg0UjBuVkEvSnU0ZnVBaVVQTk5uU2tVak5ldGhFVTlST1J2c0kxdHVu?=
 =?utf-8?B?WHJ2MEN1UnhYVitLLzk5MFdKOEJkQzMrZ0FQdmcyZnlJdU5KaUlUYllIbmxm?=
 =?utf-8?B?SHVGMHA2MnhkMDBUVldXcVNzbDVGZGhqZFRGZHkyY3ZOc2JtdVRYU3pBc2JW?=
 =?utf-8?B?amttMDJzTG9RdUdFODlRN1Ara1ZudkgxYkJ3TExZVktHMGpCUnExK3BqMklF?=
 =?utf-8?B?YmRBWlNPa1pIWUd3NVFVRzhCMW9PRFFzb0Vnd0J2aGVBeXZkdVVvM202YnEz?=
 =?utf-8?B?bWVwT0lMZ2R1YllUOVErWlRRTjM4OVZ3MmhQRWR2RXBQbHVpQlVGMW9DTm9p?=
 =?utf-8?B?TXQrclY1QStzck9PUTZOM053cEx0S0tLZE9FRDNIdThxdlJCT3MyMGM3UUdJ?=
 =?utf-8?B?K05SNjdKbTIybVRpbGtnZ1IzZWwwVnFFOGl0Wnl5QjFtSW9yRml6cDY2M0RH?=
 =?utf-8?B?YUtSRG44dzlhQ2pNY2c4THEvMCtGaE95eHV2YTVBajM3S1V2SFZoOXd6Rlpp?=
 =?utf-8?B?ZHRXYmtBVFBMYlBKa2xnOWRlSGlqaGZHR1d1bm85TE43aHYvRERTdWtsM1ow?=
 =?utf-8?B?RVcyYzg5Mk1qckxuZWFNZnFYdzhlckhydjZxNUZ5TnFjbmtrd0VNY2Q4a3ZF?=
 =?utf-8?B?U3hmZEsxMFcxRGx4VHl1d1FYYkx2RjA4MElXY3h4NDZPSWp6ZkdoWUhZWHRH?=
 =?utf-8?B?T2xrL3NYSzBmOWF0aW12M1FVakdkSHhjRFA5MHBtQXV4Nm1pbnhpcy9tS2dh?=
 =?utf-8?B?UkMvbTQ3eXhyaFZmQk5reDhybGFIaWdWL1NweU9icXdubzBuZjBQVm12Lzl2?=
 =?utf-8?B?MWo2b0F6UXNGTnJHOG5WdmNUcXkzdXlzQWNlTXhLRWFvdkd0V29ockJ2SFh1?=
 =?utf-8?B?OXpTT3BUc09icmZaaWhHVjdMbFd0L3NCVFJKKzZWQ1pKL2RyVHZqU1N6aVg0?=
 =?utf-8?B?bFJBYW5FNkp2eHJtNTk3WWo3SDVzL0NjUWg5ckpobTREN1Nkc2VPYTJ0Wll2?=
 =?utf-8?B?VEhtU3R0OTdCbVV4Ym5kM05SWFc0YTlkNVNsbG12NXc5bGIvVUJZL1FEZWR4?=
 =?utf-8?B?Ny9DMUpBUFhMblFadkMxWmhSSFJEdEFFSHpKTUtVOFVFbjlZSWxCaFEwdHZw?=
 =?utf-8?B?MERzZXlJdFIvbHY5dVdQV0tIVE1ZQWtHUUhoVXV2M1lEUk5BKzZ2THBpRW1G?=
 =?utf-8?B?UEMxYXVtdVlZUkVjWlpLa0dGdEJBdHk4a29kV1FsaXF4S0pEUTN2SHJCRTNV?=
 =?utf-8?B?UTZqY1Q4UE9vQkFHWVZmNDBWUURuRUpHSm1BdzE2N1dzS3ZEeUl3TFN5M3dU?=
 =?utf-8?B?T2grUlFGK3hJSDArVGpTQWljRFpRMVhES3QyZjc1OFJCa0F3VVE3VnVQdldM?=
 =?utf-8?B?NXlaSTdKaTlTWW8wTW8zeVJYUDQxZW1SYjlkRW1zcDYyWXdJQUptajlwcXM3?=
 =?utf-8?B?cEJwc3E1WUNYaE5uZE5WUER0dldWR0JqS3N4dFVCNEVhWjV4djJ5UEFvakdu?=
 =?utf-8?B?L1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <195DDCFB72902844B8F9C27F903DA4DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0a7x9QFawz9grr1X59cuvx3MqNDtM6A7hLh3zp7J9nkuL3WTto7CyGFO8RfGb0tXE/kTfHEm2Xb52HCtblXx2JrZvLssi/VYkVUxv+QnFlLLtRrV/onJrojRxeodWpSBohSJ0QVxm6YFDwFt2XdMPQ1Org40M4UiMIqyDeJ7vYgQkSHeVnhyPX20YzQkgi4Ym63LWptSNzjK5pAL/khcIoh5kAy7zmPkoBtk+NNMMnrNK8IISM/FYMC9ZqB4M+IoVI/e51fqvyR7L8DpPAFFWvUe4kipArzL6KrUCCyYynWA0RNoFZUgCLurSNCjGRknEr2tL3xdTWM3Huspu/qMDAulfjv3ZDCjSkAbDzVMfDeMOz6x4nm7d1ctCl9Jfhv84MmNjcitgM2WtJphVDs2vClQRhkoLZbKhrLX+jCEqRNk3PSDnaIHBOOSK6/peLAmx151cVUbPJE8N31dtPxlmARUlXtxypkAP3Y0cbBgW9iJXAPID/jrb9YP6xN/OpXOpc1ScZxQ6nSKr3iX1ST5vBPsoDreSoiJ4vYl5q0MBcQ0hRTz1FiX3ELrrViTZuy1NO9WwuCFz9ye0dlWPw/PKi2kEYQSfceDO6loHx+lzdID9eceLuiRMH4ru75fpqkzlurcnLhjF6GEMIU3v8MM+gwQR/tFnFlMSzxA2zglLTFbAP65tRaYaalWTeb9NOTzLQuk9vMx89ru0qP+aYIAJ/lnBS2Zce1Ad+/gmniVCpqaXEPBfXRTvEvOmwVWaHFHvqlPKppwCs/gIj/zM1gWjBDgiu6Il3S/NXC0mARdonLzOBhqtViDtxo2nVD5WFLy9p8Hzn8N7OW8dXzOGiX597IVGwSc2XNBvo2LU+uEn2mOUU0bqTiZpHSk2SnbZF5U
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87962c96-3e48-49fa-0ab1-08db1339d221
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 11:58:46.2032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fv3y6J18j4Qb/MPpDP/aBPJPqd3UchDoWgHDAGCbc0R7RqL3PsKLUW6NbCu5kSnas4jSo7LNLTbt98DKr2om5mxUISqxmDGbcyiQfxB+gfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7524
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
