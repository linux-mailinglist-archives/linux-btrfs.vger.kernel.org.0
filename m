Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF26F4341
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 14:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjEBMEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 08:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBMD6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 08:03:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4D11B6
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683029037; x=1714565037;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=GETBCL7ILetV8WjB3c40+dhrCBTaKi1tyfzE2JYsir8=;
  b=cr9mwqlDApXGi8aeqGFykmW0Y6dY8jCMEo16WeaICVbwQ4mE0Gm2pPBI
   gf3DoRbeb3dUmwUCkOVmNyYFCrUOFF00ICsEAjsXvueWmUj164GR7gLLZ
   pNSmjhL8ClyhRrXfbmn/c59xCygFtPIVuI4hRVMH7I/BcKpBs7xFeawM0
   6RNGoykyXBFapzCEhM8/k5e2ACSFEougvylfZ6dI7CV+R9MOLvtsm1ZaE
   tnOdeNZfdsvPLRJQizqGXq8VetlAbjP218cwengoQcfMcfDFp2XLPSaQi
   DOvDFXuDYOIXPqUo9heG3/6oauJXa+8bSNS/GbUqXroQ/nk7+YDRrigio
   w==;
X-IronPort-AV: E=Sophos;i="5.99,244,1677513600"; 
   d="scan'208";a="229604080"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 20:03:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coBh3rGsnLy2KYTzaOZT2tdFr8fw6oQw0GvNzD27Lskinp9eQPkADim2J+tUQK69LjNzX32TaGczQt1VbolumQLWti9sFAMevUkz3WUTYBi30+hQzngP4xggeYru80V3Ckd97DGoKqEvUljE7SvIpKKMNi05EjVDTxVYmIY0Z+vreD4fVZ9tZ9HtJyxeP5Q6tcDz8bScjkWtvgAmiDJBiQOVrC4jOv2kU8Ta4SFhxgS9RkYsQSe4CkPyOWto1uH3Qex2T5/5VOpJ1wYGFqB2YX+iRKhSTf+NY4+51WsD9nXpmlQcH2l7EihFpz7atQbTROZOziaaDjszlw60oEEFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GETBCL7ILetV8WjB3c40+dhrCBTaKi1tyfzE2JYsir8=;
 b=ie7cHaJQzHupuM5FY3IB901+izjRFr3q6q2mOWCJpFDmVPtW0fH3sXwZxWz2VmNTMUuTp6lz+kx7YmuLobTybJ/bVkrHewzxetEn8A+MPvqDOVSJ2fm7xp+aGWKBgO5EMIuQvjWTCbarvQVOqONPRms+2xIOZc6xd3RxncFQVRQleoTD+kiIAhNaGTt0v9bJEl5LRlm4OtcjN18Eo2C5CHg7XMD4J8K/Nmv2h1bBHOOGf+BtKqDAPDGVT093Zfk8ziYHiZwzSGo5g/1FnxUM6+JSCsRowOCGSHneMlsah0PxHqPsb0h0lfhAMsK2SvoZoW+Ao/h0OSWS9O37NOsGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GETBCL7ILetV8WjB3c40+dhrCBTaKi1tyfzE2JYsir8=;
 b=Kco4/iiau3JBP9K6vtcXpNpoC2eBPPaY3WsDQrpS9UjLZt7X1zjxhqbtjAoLhYIKPZBTaaktB60Wv1vBboAUoldO3hwauSFJ+pPjjWSbUiZIRWZHQvXpgTKaS3ONygElNKcsE1y8JgJGLKLF3SIA7FyHg7b8t7kC1z5vZZCeY2Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8366.namprd04.prod.outlook.com (2603:10b6:806:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 12:03:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%9]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 12:03:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/12] btrfs: extend btrfs_leaf_check to return
 btrfs_tree_block_status
Thread-Topic: [PATCH 06/12] btrfs: extend btrfs_leaf_check to return
 btrfs_tree_block_status
Thread-Index: AQHZetZOpcnoLl7VZE2y4Y4fO3zvEK9G5qeA
Date:   Tue, 2 May 2023 12:03:54 +0000
Message-ID: <96e9bc20-c2b5-9f7c-a91c-70458fa45e08@wdc.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
 <a528c8c37d20b53a0608185ecb83f870026a9917.1682798736.git.josef@toxicpanda.com>
In-Reply-To: <a528c8c37d20b53a0608185ecb83f870026a9917.1682798736.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8366:EE_
x-ms-office365-filtering-correlation-id: 540ed18f-7b59-42ad-15fd-08db4b054d08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jux4qhibN0JQVbcYmXhSK23sN5/JJl2dklTG8hGOKj8zecxcpaxP/UvtuLykO6Rz5PmMDY8t/qvEUDZU2TaAqc9MDw9XAGKetJfHuXIIUR17cnKE94nUeR1RWwdux3ii5AsCphalwKWPt7caS/2M05J0VEwwp0V/UVLkrniD0+ZuEowewakoVWE8no3gjeb+ztVVTSdS+7QPDSG/mqMIfnbklDv+xicztnpnOQ/9lKqjBKodINQ9ryLi6lLn+WGa0eCUu6oDToaALJY5h9oqLxPKs6Lf6qgpoe6ld+auJ9JgJbOBjwauPqAXF4g9h0XYsrXoy6BrKBx771S42fcAC/gHHwlqdniJAuW+L4Br4hB9d4XyqC6RYokUuNnEpe6IDKpUJon3JRXHZh1PhZfkpEIesF+2YiaxPle57xepnWn8nQU8aGkyJYM4IMkLfC2YgzkcNLnBt2DaPzdphaL1Hc9adIbKhVOxOSNBb3YbRQCVYabTJTvbx9WlvCjZ+pcdXQWg02oIe97vAqIylP31p6L5beFxH7LlDCK2IxQXuiq5K+qT/hM4NeA0n7BzxMOBdypmXfr81skzStivA501UIpYpCjcqZ29hg482KQmk9SvBmhqlSwFiGo3sXZJRDQlPK8LXfmpnkE/q9UKD6WtS2Gg38fZCZ3jf6dVygdqpYczDRRbjtgqSooRaskkTXx0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199021)(316002)(53546011)(6512007)(6506007)(91956017)(41300700001)(83380400001)(76116006)(110136005)(64756008)(66476007)(2616005)(186003)(66946007)(66556008)(66446008)(122000001)(6486002)(38100700002)(71200400001)(4744005)(2906002)(36756003)(82960400001)(31696002)(38070700005)(86362001)(5660300002)(8936002)(8676002)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjJLSnRVL3MveDZqVGJ1dUNZaGdnYTJranNFamhnWEIzQ1ZBWWxOb0FYM1Bq?=
 =?utf-8?B?MW1HMndqMldYYmlnY0N4NFRmTlZUZWZmNXZybjhXeVdRcXlTck4zZW1ES1Nl?=
 =?utf-8?B?WWkxRktJOVRCazMvRXZidGcwZHpXTkttNkdDNFFYQ1BFNzZlc2FRQkM0MThU?=
 =?utf-8?B?MzZaTVJQeWpxWGI3aHYwMEN2d3N1NFVybkVsY1JleGRvT0VuelFMa3RodHRl?=
 =?utf-8?B?YmhJa3laQk1sZ3hhZ1NsRmlFdkJlVkdsdlc1M3JzaTNVYzRiTnYwSGEyZlZi?=
 =?utf-8?B?NDN5TmFPV2VqazBoNy82ZUhadHhVdmcwVjVGWER6eUFNQk83OU5Dbm13K2NC?=
 =?utf-8?B?VThRWUZoeUlGM2lCNkEvTlhQR1hsRk5vV3ZQWkdPUzB4NVNxSjEvTk5zeG4v?=
 =?utf-8?B?b25wQjNaMDlvaEw3eEkzN202Ym1NODhCbHkySk9wWGJvVElXSGlNaVZiczdv?=
 =?utf-8?B?ZHNVdlVXelNjd2FpMEVLNGJ3UGpKcmIzSUhKQWhhaUxkbThUclh2eHkwOE9j?=
 =?utf-8?B?WTJBRXpDQ2llSnh3YXN4WFZVT2VERE40VStFd1hwVCt6dFp0Vlc1Rytvdnhv?=
 =?utf-8?B?dy9qTFc4enpyNG85amxUamIveThkM05QSDVJSElucU0xaU1IWDNlVVdQNFBS?=
 =?utf-8?B?K2NRK0JzVkl3S1h0RWZhZ01EQVpWWUM5K1NJOU1aUjRXVy9md1FrbHo1U0o2?=
 =?utf-8?B?ZHFITnFKUnBEUktMSjZVc28yeStYTUo3dGhTanF1ckMzK293Rmx1dDhFVjVP?=
 =?utf-8?B?cHhOK1NiaThBT0YyeEJlckY0aXZwYVE4Y1Z5ejdUVVpib29PYVl5alNtZm4x?=
 =?utf-8?B?Mms0T3JUaExUQzcvOE5rRUtCcDRzeWl4V2dFOVdpckNuVElrbEZsdnkzMUFx?=
 =?utf-8?B?S0lkKzNLbGt6S3FWOXpIWmRiaVhzeG1ERnA1R2pvb3lrQ0RXeTdQUXp5N2tS?=
 =?utf-8?B?ZGNVOXlWV0htcVlSNjV0K3oyOTVmRm92cnRRZ3dUZVpVVUtkejhCTStnUC9w?=
 =?utf-8?B?RDg3d2NiMmlsR0F4eFFSR3NjNnRKVlpPeUtKUEt3ekpTUUpKeWRqY2prN0lP?=
 =?utf-8?B?V1VRVHM0ckdFdmx0bGo5N21od1U5S1NOdmJjRmlxZU5KUFl2Q3lBTTR2eHpH?=
 =?utf-8?B?R1daVFVnZzVEQmtxMDc5dXM0UGdnYnZ1WXo3NHM1ZzFOWEJIbEs5VHpUR2tu?=
 =?utf-8?B?alVSWmoxdmlveUZXajhMZ0xKVjA1T29uNTA0WE1OMENWYnpiSmZNU3RPZUdS?=
 =?utf-8?B?UldMZXhGODFoakNuTUVWN09Ealc5bFp1US8rTXVaclVlYUFBRzNzUWRKbkUx?=
 =?utf-8?B?WnpTd0JrQVA4enZXd3hXRnV3YmwvMGdqTVFFN2NhaXdqeW1jd2RIbDFBelhU?=
 =?utf-8?B?aUcwc0NvbU52bWhoRFFtWTFES0dZYkM4aGVKMWo5WVk3U2NTMGZOM0M5NTBn?=
 =?utf-8?B?clBTamowMk0xSFZpRWZVUXZtcGV6ZStwYWNCbS9Ba1VXVzEzdUFZT2N4dFJT?=
 =?utf-8?B?aHRWU1pIaEhDMytTUXM3V2pxczZzN0wxTmdJdm5sZ3J4eTBjVXI0QVE3R2pN?=
 =?utf-8?B?OWRLTUtXRFd1dXQrWHppb0s4RE85YjBXNVAwVG54dStMSzBwbllwMCthTTNN?=
 =?utf-8?B?bnc1L1BPTkdKQm5CRlFub0JRcW9kOHc2NXNBcGxhN2pPQW91REErUUJqUWJB?=
 =?utf-8?B?d2ZUWmM2Z2VlOWdGdzVSY1BiY1AwcmRRbit4UWVsMHk1amxUYXQ2d0RLS0Zj?=
 =?utf-8?B?dUczTWdMemRLR3RUMDBrUkViZTJ4OExDbTZSa3o5azhFYWlyQkRMSGRvdmZU?=
 =?utf-8?B?VTlMdGZaWEhWZnFQNXJjRjFRQkpza1huVTQ1OHZyeW5yK3k3YXVPRGRJcGpZ?=
 =?utf-8?B?c016Zmh1YVBvSEpZVmVKTExkYjV6NFFNQzE3cGttVHM2WGUwOTByU3VvVG9q?=
 =?utf-8?B?RjB0R29oaVhQZUdBYTFiTTlPRDd4V09XdExyY0wwZEZOSHhYaUdaM1BaelZC?=
 =?utf-8?B?K0srUE1PN0FyUGZ4ZzNOTVpUdWl0ejE4Wml0M1lhVjB2aDMzYmlVMVcvRERz?=
 =?utf-8?B?RDV1SC9nYUZlRmZEenBmMzNXRlZoWHZ3WlZkbkp6MXFjZUJnaW9zcFVYdmJN?=
 =?utf-8?B?Mi83NVZEbXc2QjM3Qi90SGVvYXdlb1JDL1hTeVFkNFJ0T0l3bTMxVko3RzVZ?=
 =?utf-8?B?WnVnTEYvL1JUSW1reVZsVE1mbEpmOUxmTkVLQjIxb3Z4WjRTN09OL0swR3BG?=
 =?utf-8?B?UEJ1eTNyN1hSdlZxNllXSFgra0pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A314C60AF6BAC4AABA3CAB4A137B83E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nlBpTXnI7N5ZjC5q8jK2wCymgMluBlK8u+yGZunCIp+pw6sImtdCg76pqw122S8bF5RHklKrgOY6AdiiZ2pp4s+ZHyJ41+vmS95zsS64W08YCqgUoZno45uKO6tKzoFg9x4sXvEY/PLDkBg7LANxluCtZV7XA3ekwH5DBmE8kpgopYgh/D41vlsgzchWnvRv4l/XZzqkmqXTE4NmzKbvoH11y8w4r4t/fcAUskMr4cf7QHXyFIsl4tjwwjFtJ+XPiGOtdKpsnxdOQnATWjvlMO/sfyyXl0EQOaMdUg/zbBrC4imrDfsGXa+P2+E7z4YBrkrZO85SFOwpYMm2SVhO3wT51vVUzuulXQrSzorqJwGu23yALMy9je6b681Jt8cs/fYxHRyzdLeUKgIgB5pB2wTNYvvi6nOVkN9OPqXYniuQ4KRvidW73WdjpG+IoAfyX/CR5nLZF0d50H9wsO/wLLgqwftCaujMDcGgTufD2qCHsrE/fVFxXgxoDSXDqtFWOokZ5x6gTCla/Mk6yKBxEGpy+8bzU7q9jhiSZMeyUVmU40E8za1zWx54uGIT9k3O5NjOCBuUEWF9yU7F6QMdQLg9uX4YuDpeN+z0FyPEs5N6ihLDUpZkLaeaxoiymhan8PAwJ21rPx20VOgYBQ434Vjy8wRkRCcP/jfAkrhq6uQSocFDFevTKwA+1C3VdILKQbYFxxXkDv4gADIYRGNBD1ACez8VEc71O3rsITBEDyJL0SGv208ZgX4ozdb/cKTU5IisOCBR9MZUoqHvaJyjGPIAKwUcA8sKdUxfxwKKaGhudLuc1SedcOqzm1E06LFXhc+6a26Zdgr1ejoF4agsDw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ed18f-7b59-42ad-15fd-08db4b054d08
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 12:03:54.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDZAW9uRap1fw2BGBUCLi2pNlyvw/Yuxhy8U3U2OEfQWmiTf+lODb/VfdwVOgpvga60icrPOWyAcZ8RyKRVOcYfiNRWNIpl4D1tupYLsbf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8366
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjkuMDQuMjMgMjI6MDgsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvdHJlZS1jaGVja2VyLmggYi9mcy9idHJmcy90cmVlLWNoZWNrZXIuaA0KPiBpbmRleCA1
ZTA2ZDlhZDI4NjIuLjNiOGRlNmQzNjE0MSAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvdHJlZS1j
aGVja2VyLmgNCj4gKysrIGIvZnMvYnRyZnMvdHJlZS1jaGVja2VyLmgNCj4gQEAgLTUwLDggKzUw
LDE1IEBAIGVudW0gYnRyZnNfdHJlZV9ibG9ja19zdGF0dXMgew0KPiAgCUJUUkZTX1RSRUVfQkxP
Q0tfSU5WQUxJRF9PRkZTRVRTLA0KPiAgCUJUUkZTX1RSRUVfQkxPQ0tfSU5WQUxJRF9CTE9DS1BU
UiwNCj4gIAlCVFJGU19UUkVFX0JMT0NLX0lOVkFMSURfSVRFTSwNCj4gKwlCVFJGU19UUkVFX0JM
T0NLX0lOVkFMSURfT1dORVIsDQo+ICB9Ow0KDQpXaHkgZGlkbid0IHlvdSBhZGQgJ0JUUkZTX1RS
RUVfQkxPQ0tfSU5WQUxJRF9PV05FUicgaW4gcGF0Y2ggND8NCg0K
