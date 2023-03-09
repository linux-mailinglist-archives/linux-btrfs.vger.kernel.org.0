Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7A6B21E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Mar 2023 11:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCIKxs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Mar 2023 05:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjCIKxT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Mar 2023 05:53:19 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7D64B20
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Mar 2023 02:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678359193; x=1709895193;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UjcPMg91Qw17ehwOhhJH8ZFxqLLxDdVlebC/ekgvF+4=;
  b=lY71ZDgBjdNavMkxoG0vYJWONdzktdUFczbuhT+N9t18gkX9A5t+1BoF
   8chsPmmLzoDzbmPgPvxGaA3FuYUr7jaDrNgikFC318R/BL/Kr5qh8EpcF
   lIg04AdQ/ETv33WlTcS4n4K326C+mdWsFaqVzpTJJbGfUTCMjcj1j0kwi
   CFRXpNxsbfuKu6hIuvpiqiw3wJ1DsUPfxlk+8zsNgxqFOylCyFxCf+jkk
   BR+kfQer5fwsZ+d3zmhySdVakmV1uHEyZADQ4SwzpoZJ8Ehg7aZYhNsXF
   u042aCcO7OYcEBIwwf928PBwW8UGfqxEMPn5oo3nNabrPj6iYS09xIXeC
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673884800"; 
   d="scan'208";a="224994474"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2023 18:53:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNKZcdG5cfTPYvl7SbdeN5sr06Kabc+v1tIVEKTW/ll8txeCxgWCo2I39loHXn+FICdJNHPMJv1WuWwc9eVgmuZ6/AavnoLRq0Fc8LADchAPsLoWbvCzG4ruv0o0JVAZmyS8+YMciTQsRaysL401VVbvWHQJjJzatWTps7NnetjWd/hbuZnQAZYeWfI/fiqzGCndaeDd9h7IbRGOWMOONZx3i4G9Qg1HXgXy3XINZbEFHZltvukEdlYVycTifq9ZLD5CYYCSP8LFOyFhjV7dZGyRW0YQ/viQX9kzW+bU3yM/GIvoklwsJmN04yTGYp7yDJRUhq9NDgJWX1mn50Vq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjcPMg91Qw17ehwOhhJH8ZFxqLLxDdVlebC/ekgvF+4=;
 b=aXHylG9IWF0fQRQG0OdM/JTsmQ59h8N2O2cu2kYusq250AzFBfN7u+FSbXMxYucQR78dfnVuOsvp91XbyNB+7uClNuZEfXoTS+Z7K5RQQPWSeeCt+0uuIhDUeBCyzvdTX6aKDaP0dCcc28QmFGzfhYkU5qrCfubNGJMbQ5RIgiJL9mpk7Ivk6UUjS0DMGUNiCD+/9BKG0zvjLRgG3WupSDDPZoeFhB9AK19wgbyIlv9Ynm5IFz5ljlRJ2dcsDzIsulfoQAj+nwNXzMRguV+LLcGoCBnLzT7qPQ/QrCO11J9eMBYXD0xkB84SBnnolBCFyll2K3Hge6Qcsf756T51ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjcPMg91Qw17ehwOhhJH8ZFxqLLxDdVlebC/ekgvF+4=;
 b=iOhLkcUhSCUE2ygkB5EA3VbXqZ+tz9tocZEMmqN1p3MLXWSIXlFg03LmT2ybnOYkQR4SJzJcUV/MzkM88r7IuiJsy4gOeLJ0jYJvnnNN1fskrYml3K3WVJhiz7zhNKU3sp2N20gyoAC6Rm0t9F7FslW7TTig143wVL9DuO3Og6o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7421.namprd04.prod.outlook.com (2603:10b6:a03:290::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 10:53:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 10:53:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Topic: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Thread-Index: AQHZTOvFIu+8wyTHXEOnol2yZkL+G67nUggAgAAHeYCAAAWhAIAAA46AgAAikQCAABkfgIAAdl4AgAEG74CAB4aIAIAAWdsAgAFUwYA=
Date:   Thu, 9 Mar 2023 10:53:08 +0000
Message-ID: <ff038aba-943d-5df5-5673-4e475dd397b2@wdc.com>
References: <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
 <ZACsVI3mfprrj4j6@infradead.org>
 <bde5197e-7313-5017-ffbf-a528559c38cb@wdc.com>
 <48acd511-7f69-4c42-44ea-a39973d57c98@gmx.com>
 <ZAIBQ0hzLTjOIYcr@infradead.org>
 <e9e7820b-9cf3-8361-cf3c-e4d59baa5b21@wdc.com>
 <20230308143330.GB14929@lst.de>
In-Reply-To: <20230308143330.GB14929@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7421:EE_
x-ms-office365-filtering-correlation-id: 9dfb09e1-abe4-46a0-296e-08db208c780a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xAZGJrk+fC/Jrg4RCNAty6n1xks35NgW/sF7nEG1NeWuV17fjsdUMQIr7JWlMfF+nTKG+iT5tbfQnC3sKVwHAxoNUlA6k9/EXgVQjd1kFMCzLRN7kQOlOqNhx6ikkJHeOYPn74KH1XruB5rQJ4NTC7h8JCuAhKL0yKlPE7Nlu1ChZ4h00Oga00DvyMFDZ0l1RWXZc5O+InXqTXnIp70BJqXxpUO6JL07fidGnstvID6PG4xJjSu374uiymXThZLmU6BVkSYkMeSpfxjrm9hD/d6kKKtDb5kMNsskLRRkfxjtsuaSjFVDWijUNcwWw5xcCB5j7SZ5+Cs3P/sXTbRWW3jk56InzJw3LE5JOsbIb4ekAkUhcIPMqb+ygx39G1goDZhQbhocacKOIfw2C1ljamFB5n7zcqSs7ULrCOPW7G0fm/eM3gstYSOw4QjtAHYiYehFXmzZGkVqYLi6FaNvoHE5iJOPSrWqIefZhGUTgT4PmOWswGlIUJJelfNJ0ctHPzALezXIbRcMbrtZXvzZctlZN6mNNHLPZs/uqtnhfzA5QqoSifI8pYs9LmurP/tJe0EG2LQFCD+7t5VkIP1NnHzOXZJgs1zo8zDl4wg9Xb/80IEhrQc8EgCmLspUeXI+hahrG+JCWH1RLQQQMQRCn/QaWrAXjLihoAaXBVhh6VtUhjyket4mnUddPbu1Dat2/rWH1edcNPuwg3ZYy96v9ooVLUIc6EjmwwgBrorfvjCmCq/20tam5wRB/COnm1nKIEHA2xzbsFiBUL5J4ZNekg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(8936002)(478600001)(54906003)(2616005)(6486002)(31686004)(122000001)(186003)(64756008)(66446008)(26005)(66476007)(86362001)(8676002)(6916009)(4326008)(38100700002)(66556008)(66946007)(31696002)(5660300002)(2906002)(6506007)(6512007)(41300700001)(53546011)(83380400001)(91956017)(76116006)(38070700005)(316002)(82960400001)(36756003)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnNqMVN6QlFXNTNEM0xycFRYeGExRFRCUnF6aU5sb0tTRS9pWm1zdlNtUnJH?=
 =?utf-8?B?TElveC9tY1FpN3pHLzc4REhkcDhPNXJuT1gvcE8ydlYwd3Vzb2VPSHZxSlNS?=
 =?utf-8?B?aC9oQ1BySW01ekM5dGxQTnpXR0NNcUdVMGtNOFRLOE93dDJIQVV2bStHUGhp?=
 =?utf-8?B?SlFFaVBsbzVhR01yTlk3TkY4ZTNpZCtWRTdFTnQ5WXRIYjZFL0t2aXZXNzln?=
 =?utf-8?B?L29BNFZkNk9rSDZsd0F6QSs5NUtzQ1FYT2hVOTN1aWhJaS9YczhFWWJvMXR3?=
 =?utf-8?B?RDU3bVJ1NkpxdkZjbHhXSkx1aFhMOEMzdFhhR2xjd01PRHo5clZjVFZxY1Nj?=
 =?utf-8?B?SmdkQUh3Wm52S2hPZXNXUjdVUDJyRnZ6QW0rbXc2S3RZTXNoSzdJeFRUQm9l?=
 =?utf-8?B?VTQ5bmZwREVGNlFydGN2SFlqb3A4bnNXWVd3MUhCdHIzSEI2RGZ6WW95aTBl?=
 =?utf-8?B?NmNpYmd5NmlySmhQVk5CS0xhL3g4NU16N0RKOXVmcGhuSjRLWlpIU3JkUHpy?=
 =?utf-8?B?VGh1SEhkMGdMQStLS3BKcmNxRnpRUkJDTHp2bTM4MElnY2tRKzUwamt3ZjFZ?=
 =?utf-8?B?VUZjNzdHLzRkME1sZnkyWEp6d1VYVVV0WWlyRG83cDBQcUR2UFB4ZVFzSTVs?=
 =?utf-8?B?ek80bEFFVjNrazY4NlVMYUNmelJrbUZiMTV4V3VVa0E5dWdEYlpLTDFWUlVV?=
 =?utf-8?B?Z250eURVQ01kencxRU5ac2k2K1BveGZCSTFPc0dnM2s2RDgyb1FRUksyMjBS?=
 =?utf-8?B?bE51RTJqTzZzU0FleGh3YjAxTXNURUdkbm4xbTZaVExvUmw4dTl5RWVtQUU0?=
 =?utf-8?B?UTlBelRPYVBqR3lVWUFxdFhPcHpCYTVaNUdxakYvaysvbUdmZDIrUGVGRXlw?=
 =?utf-8?B?VEswRW5yKzlsb0xHTHJNUzVlYnZCTXE2RCtaelhuSmJXZTZHMUtKMmVJSzJC?=
 =?utf-8?B?NWI3ekZYaEczUnhwVUtwOHhId1N4ZTlTOWJDVXNoY04vMGUwb1lCaTFqZHdo?=
 =?utf-8?B?OHl5azIya0hBVGVBT2g2ZW1GL2FENDNxRUtyeDBLUWt3SlBkS2dPQWZ0YitJ?=
 =?utf-8?B?VVh0cCtsdUVFMjZUVWpPUnhVRWZCYldEdmw1bVl4WXBpWkY5QXJYdFVGS0dn?=
 =?utf-8?B?RmxETnZSV0xKZGRMdllCMTVBSmVObzBXdXRBZExSa0pqVXd5M3J1Y0lCaHYv?=
 =?utf-8?B?aDhiR0ppN082R2c4aFJ2c1FxOGVpNU5CamhhQ0ZicjVyVjhEWTJ0Wk5DaTlF?=
 =?utf-8?B?YXFqRzd1MjhtWWVONjRuQkRDZzVmMjN6QlEvcllrdjVHUVJ2OHVIY1hyQVgz?=
 =?utf-8?B?enV5aTZNMzJFZjNNVnlEc3ZoL1BWQ1FuUHNPMUxkeENiYjIvY3h6ZE9FbS9q?=
 =?utf-8?B?LzVheE5qZndnZjlFaHNUdXE5OFo4N2QvTFJYNHBrNGFkOG5ZS2J0Z1VnY050?=
 =?utf-8?B?azFzNVF2bjB4YXRhSXFtaDZzU0xNMTBsTm9pUjY3czNuSXZtK01oVjZhVG43?=
 =?utf-8?B?M2diSFRlbTd5NzJvbjk3Y2tETy8zcDJQS25OVFJhUXd6SlF6WXlBYm1CeEI4?=
 =?utf-8?B?QWViRlFtRmFNdmM4SDMwYlN4SzZLK3BkeTlEc1ZJQXZuQVJnVEdxUkZTMVk4?=
 =?utf-8?B?RzhzRHRFc1Z5bXZLNlRta2JmVXpRQkxtMXByRnIrcWZVbmdBZlN0Ykt3bDZ6?=
 =?utf-8?B?U0JnVCtNTlIyc0Q0bStuMkNIdFJ6V3paNGVmTXYxem1SS0x0RVVrVStGZ09a?=
 =?utf-8?B?a2h2cFRqdEZNT0c2SlRQYzUxL29WSkdYZWpTNjFDZUErWEl6UmF2Y2lhUHd5?=
 =?utf-8?B?MWJ2Ylg3MWNNbEJGUXpKOEpwUDlvMGJ2MnNDZ1p6aVpTd2R0V2tJOU43eVpR?=
 =?utf-8?B?SHBKSmJGUC9na3dpUnZWUjJYSFVEYWRCdFlpWmhpZ2h1VVVRK2dxWTVaaG82?=
 =?utf-8?B?eVcrUEM5RWdkUldtUktydFVNTkpnbzV1aWdnRzMxbWtBcSsvRXl2U1pmRGlL?=
 =?utf-8?B?eWFHK0M0anpKK1FpSXU0bGh3N2t6a3lMakdQMnc0dU5VWXg4Y1Zra2ZneTdm?=
 =?utf-8?B?bkdXNjFld3Zzdk4vdjdVSTI5Rjl4SkFHaXFQbUdaOHp5UWt4T0x1ZzdGclFs?=
 =?utf-8?B?QTNuNUtNUno1WmU0MnhzaE1RS29yYVNDaDdJQWx5UEFqZVU2ZlV4NlcwQ2t4?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E801697D13956499F59BFFE4250F110@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n31woXbKapqWM/oqtdMbKh3W6xvoTf7rZS2/e8tdaBv8kQPt8eOn+TJ0tVZKMAxD4J+DN9KqbuDP/qWYKU0L4Mt3ym6Bj7iiOIdkP3Au8zYiAvni8baWyusIUYRlXW8IIFerfKo513ahnYE5W2aqQ9vjKrmtBWuzL5LAualPDI+FATBbOcb+tEwPiJ6nIgdWZ2f1dIEzbUZulgN4OnNxpJlPcFo0uShrw4lLaDGLNlMFlIq6dyhHWj4wlmKZNUw9HUSLxe7uYSqelkRS+zcVMeFuQswaIdtCUWDdEvsCOdgE3WjRFH6E9Fe0IOGVuFvqvkWQ7nhzMo921gGU8KS+Ugip8zXIGD68uIT6wOkiIK+MWKopCymTwWD+LVdYqTHtm8SvI9AVf4b/4NfLTlEBrG7tCWL6w5DoTd2YoG8O4zIxlBvoE3Hwo2bM+unZ0Tush0gfPmiNxXjfUJObaNlZsJEJAMJM9Hkl07QOY80x0Btqhqq8oaWguQ2s+beSleZN4ZoHx3G9hO9kw4i2EiNkvWCpWJSm7JCi5/uIHIKM9M8VT38bD3OobZ66mjaeOOhnk1czbQGcXvGlMRt1uYC6QryI0hBtiFkZEcl/gdcXj5lGjj12ViPCYUBLxOcnj0J87pOjJd9ZlzTxLaVlEMOmTM09dTIJ07Kv89j6wxZS9+mSA7abSm8uHEIFODWVvqI1CIi7MNAmpiJDtIcjfgLPPbC8rLqRBQ8GM5pqKlEQ81mRarQmZCTNAEWp/GxxcSkJBBUCfk/hO+wxZUYc83rt58Awq0Nv8uXvEOey76soQ8XzlUXQ9CvyjKg4AlmE7eKmW8XjveVG8q8VXM9T3isC3l32poV0rWk8mxVuMf2RvCGyMxM+xclkGNulfhjVadt/Q3jkZjreSQwKQ9/FYZgjB5yD/F1NewAFjxwgZzUXAZo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfb09e1-abe4-46a0-296e-08db208c780a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 10:53:08.3874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /IuSkFqQd15oujjdoHC83pwUMj4IosYDTyCa4ZHHuH0TquHiZEJ4d7og0u43+hRyFUTruEmCLQljlF9jOkJAS8ZRdsHgSBiW9fLFU7jKKlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7421
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMDguMDMuMjMgMTU6MzQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBXZWQsIE1h
ciAwOCwgMjAyMyBhdCAwOToxMTo1NEFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBAQCAtMzkzLDEwICszNzgsMTIgQEAgc3RhdGljIHZvaWQgYnRyZnNfb3JpZ193cml0ZV9l
bmRfaW8oc3RydWN0IGJpbyAqYmlvKQ0KPj4gICAgICAgICAgICAgICAgIHN0cmlwZS0+cGh5c2lj
YWwgPSBiaW8tPmJpX2l0ZXIuYmlfc2VjdG9yIDw8IFNFQ1RPUl9TSElGVDsNCj4+ICANCj4+ICAg
ICAgICAgaWYgKGJ0cmZzX25lZWRfc3RyaXBlX3RyZWVfdXBkYXRlKGJpb2MtPmZzX2luZm8sIGJp
b2MtPm1hcF90eXBlKSkgew0KPj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBidHJmc19vcmRlcmVk
X2V4dGVudCAqb2U7DQo+PiArDQo+PiArICAgICAgICAgICAgICAgb2UgPSBidHJmc19sb29rdXBf
b3JkZXJlZF9leHRlbnQoYmJpby0+aW5vZGUsIGJiaW8tPmZpbGVfb2Zmc2V0KTsNCj4+ICsgICAg
ICAgICAgICAgICBidHJmc19nZXRfYmlvYyhiaW9jKTsNCj4+ICsgICAgICAgICAgICAgICBvZS0+
YmlvYyA9IGJpb2M7DQo+PiArICAgICAgICAgICAgICAgYnRyZnNfcHV0X29yZGVyZWRfZXh0ZW50
KG9lKTsNCj4gDQo+IA0KPj4gKyAgICAgICB9IGVsc2UgaWYgKG9yZGVyZWRfZXh0ZW50LT5iaW9j
KSB7DQo+PiArICAgICAgICAgICAgICAgcmV0ID0gYnRyZnNfYWRkX29yZGVyZWRfc3RyaXBlKG9y
ZGVyZWRfZXh0ZW50LT5iaW9jKTsNCj4+ICsgICAgICAgICAgICAgICBidHJmc19wdXRfYmlvYyhv
cmRlcmVkX2V4dGVudC0+YmlvYyk7DQo+PiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiANCj4gR2l2ZW4gdGhhdCBidHJmc19h
ZGRfb3JkZXJlZF9zdHJpcGUgb25seSByZWFsbHkgYnVpbGRzIHRoZQ0KPiBidHJmc19vcmRlcmVk
X3N0cmlwZSBzdHJ1Y3R1cmUgYW5kIGluc2VydHMgaXQgaW50byB0aGUgdHJlZSwNCj4gY2FuJ3Qg
d2UganVzdCBhbGxvY2F0ZSB0aGUgYnRyZnNfb3JkZXJlZF9zdHJpcGUgc3RydWN0dXJlDQo+IGlu
IHRoZSBlbmRfaW8gaGFuZGxlciBhbmQgaGF2ZSB0aGUgb3JkZXJlZF9leHRlbnQgcG9pbnQgdG8g
aXQ/DQoNCkkgd2FudGVkIHRvIGF2b2lkIG1lbW9yeSBhbGxvY2F0aW9ucyBpbiB0aGUgZW5kX2lv
IGhhbmRsZXIgdGhvdWdoLg0KSWYgYWxsIGlzIG9mZmxvYWRlZCB0byBhIGNvbW1vbiB3b3JrcXVl
dWUsIGxpa2Ugd2l0aCB5b3VyIHByb3Bvc2FsLA0KdGhhdCdsbCBiZSBvayBmb3IgbWUsIGJ1dCBh
dG9taWMgYWxsb2NhdGlvbnMgZG9uJ3QgbG9vayByaWdodCBmb3INCnRoaXMgZm9yIG1lLg0KDQo+
IEFsc28gaWYgeW91IGRvbid0IHRvIHNwbGl0IHRoZSBvcmRlcmVkX2V4dGVudCBmb3IgZWFjaCBi
aW8sDQo+IHlvdSBjb3VsZCBpbnN0ZWFkIGhhdmUgYSBsaXN0IG9mIGJ0cmZzX29yZGVyZWRfc3Ry
aXBlcyBpbiB0aGUNCj4gb3JkZXJlZF9leHRlbnQgYW5kIHRoZW4gcHJvY2VzcyBhbGwgb2YgdGhl
bSBpbiB0aGUgb3JkZXJlZF9leHRlbnQNCj4gY29tcGxldGlvbiBoYW5kbGluZy4NCj4gDQoNCkht
bSB5ZWFoIEkgbmVlZCB0byB0aGluayBhYm91dCBpdCBidXQgdGhlb3JldGljYWxseSB0aGlzIHNo
b3VsZCBiZSANCmRvYWJsZS4NCg==
