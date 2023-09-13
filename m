Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A361179EBCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbjIMO6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 10:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjIMO56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 10:57:58 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8653B7;
        Wed, 13 Sep 2023 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694617074; x=1726153074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3XvGBwvs8CAp4FnTJW2Xrkdbu6BRzA/KaipkioRBlh8=;
  b=Uyx0VLEstXdeXkPtOpLnTl7aklquEn3lrXY9wBmpjJbJPz9GXmiHREM2
   aZnjddd4ZUsm/TArpehp/FqlYYRQiPQ1Tf/9JaDhqRY0Q32DIVCExshhQ
   ej+YLNIDGepurI6gdZtPeBu7QFmviro3gxhB7aQAPilEwOmJtkZO2YYTQ
   WB5Y2aCCiA7iDKINB/mESdGUc8l0ZJ5ofN1/p0RVxbmicuOBnn9HtoZqt
   +fdLM/+9ajUzckQoPnnDtUMK5ub6GfeT/RcaOYEdn0uILaxpQZ28g8net
   eUFuBEma2OFBzokbVPnoWX2f4ulNVFv4AzMBPzsxUGtPNCuddIrxN16Ba
   Q==;
X-CSE-ConnectionGUID: KnDQQ+i9T0+ckm6dPyW3sw==
X-CSE-MsgGUID: JBlu2wusTAyFTrxzkrLkyA==
X-IronPort-AV: E=Sophos;i="6.02,143,1688400000"; 
   d="scan'208";a="355945530"
Received: from mail-sn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 22:57:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnuYxvuAKBkaUW5RX92swED+rmPlaooroz8t6Fp8Axxbofwga60Ffo2RdjIx+qFdrWISEh+TmSSsOiXxoB0sVYQGI0fE8HiHfHLQYJBjMueztEoOIHwRdQrQWLG89KHR+wmj9EdvyqkZWqfhOB5oXp+ss6sjqnfiXNAneWiluHNyqQX8kXSB/eU+teDI3iHI4CSOtslXXWsXutCW1aB9OX7rVAy68yPN608NSd1On7V1RecF1hihY7unWcPL2BWo128FwN2C6a7ToT2pzWL4qRfzhXpskgv5QTIJUtMBDGFOX0arEzeQaPRHdnv8HJrdg7S3sa8BDtQn7UkGfwPGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XvGBwvs8CAp4FnTJW2Xrkdbu6BRzA/KaipkioRBlh8=;
 b=hm0aIbSkon/1dOyI2H9YVhFFjPDkT8xlWE4Hr+1apm82JDGaSvkJm1/PQ2CAJzEb0/HLU8EcxGUEiux9UwRJEG1Y6HtST45du5t97Uhvs2jTXSIHgbY2qhLcUVv2tfQxmDLBBjBd7Ps//P4cVd5eAAtPTNHyxMRd0aQrIcxL0M2OQUWwTmp0BDCuoP4yXYZ9YtID7YwS/aONmqA+6c7uiUrbiP2LeNP7RjcAsZHxFkgzh/l5TifPBwKHprdxUROosvUvQg32Op5le4Ye6qvebHRmMkapugXc464v7Ven7eZx0p1F6xx/BC21uVwFA0A15n5jerKWVjLRP7FMS3M92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XvGBwvs8CAp4FnTJW2Xrkdbu6BRzA/KaipkioRBlh8=;
 b=QkdSPI3OaVOXX3N5r7fOhZBtitL0Rsk4BrRe3LKn7xs0w3au6G8USGinDNOaObsEDGEa0IdHEQUC88aUIzT5eDoC+Nnu7+8vHJlDlJnzAqse/I0KoG8u327k0xrjms/OCwL6Wif5BWDRl1bTs2Y1PY6BS621NkGZkmT3CWZr6nI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7748.namprd04.prod.outlook.com (2603:10b6:5:359::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 14:57:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:57:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v8 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5K7VvXFOkD3Ns0eOcpvmKIx9uLAXpw8AgACfPICAAJNxAIAAAjmA
Date:   Wed, 13 Sep 2023 14:57:50 +0000
Message-ID: <110deaa7-9682-4ddb-a5b0-2b5f627f6044@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-1-647676fa852c@wdc.com>
 <20230912203214.GE20408@twin.jikos.cz>
 <50cfa5a0-c209-430f-8c00-54ba41c3791d@wdc.com>
 <20230913144951.GL20408@twin.jikos.cz>
In-Reply-To: <20230913144951.GL20408@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7748:EE_
x-ms-office365-filtering-correlation-id: b2d12ddf-9d64-4872-89bf-08dbb469cccb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5NhjpXGuz1UYIY8D02GUQFkFZ+Q9Xbncywd7hAhvm1UuP+ZzxNlYYHl1w/POCY/iwSA2uNQ5nO1zLiZah4h0nZxnZRBPGOyPr3IcZ0gkfhjcVT1vglrV4b9axiSqn+SGetL4Y0nDWoHD8uke0kt0GY46TXMbWA/R+WjKP/PekaB/wm0b6sE7gxLMR70OWweAtiC43Cbax56xtsyKZvt2jMY/A01AXyHUjPtVQeYPeNCrgfC2ulqgDF9YFrvzanJs7qkUhAryaAnX5xXZqa03v5pptK+wjJlBj2LnX4/nNAN4kzBZi0hc6ERP8+rTJD7ldDukedhgYaq1jxeTrr17+gXt47EUXdkKCy0s6r8ct8CKNq9nwvGMd1fKXV51HYxAjG9kBqkcM+JDawB/CWfpxxNy//LhR3O/zuthjZbfRaB8B08z0nmV8pirdGYJfRHCQX/rDV772+9+IAckAw2inhkUVJG+vNor7buamPQbr9mx8aI4Whxt+g3WVbTQA8GOk5PCoPyJoTBM9gjSR+JrUn+H66mj3snyxs4kWNXXSY2nBwked0aKaMbJpJaD5YSkCjDfBVCsdkpGBQ3YzgQZzAfgWcMhd8/466UlsOU5MZvfT2j2nQ864PDuOdXXQQqkZFSjB3r0OazshZZEJfV/xw5NU1UufVBtu8knxZ4ihDHu68yDHEeS60Z2c+yHdpL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(26005)(2906002)(83380400001)(6512007)(2616005)(6916009)(316002)(66446008)(66556008)(66946007)(76116006)(66476007)(4326008)(54906003)(91956017)(8676002)(8936002)(64756008)(6506007)(41300700001)(5660300002)(71200400001)(53546011)(6486002)(478600001)(38070700005)(38100700002)(122000001)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WENuTmtFaVhCSU1veUZKKzNTc3NVckxhd3pIZlBYazdkdGVjR3RLQnNtOG9q?=
 =?utf-8?B?eFNPdUY4NTJCUndoVFdWNG5yRU1RRkVCUjd2RUtvWHlIS1ZPSzJpV3QzR09Q?=
 =?utf-8?B?Ylc5R3B2NEp1UEplYmtFbXZ1aTRtS21aWlNaZEpBc3RsNE5wdkE0UDJTV21n?=
 =?utf-8?B?M0tYeUZaRWJwSWJrL25mV2JqK3lONmZIN0dGdDNsWU13S01TUmo3OURWakdo?=
 =?utf-8?B?eWlzVG9KQUFoLzByMWFXU2xHcEhocnI5elNwOTFtRlFSRGhqeDVVcXZKRVA5?=
 =?utf-8?B?a2J6RWZFcDltUFpBdEloYW1FcktqU1NKU2cxTlBPVFZlQ3RPV0hQWW5QUGht?=
 =?utf-8?B?UnFSRmNHZGJ2RnZHVmJiR2d1eHlsTVRLcUJaa0JhQnNWVnhSYUUxUFRVclpp?=
 =?utf-8?B?VVh6R2k3OFBaYnNmcDdhdmRwZW45K0c3eU5zWnQ5MUV1b3p4RFdhNnlXUm45?=
 =?utf-8?B?NENDREFtTThyVGYyYWIzQ1pQRlRyOUJjTFVVNEFZN0wzSEhuSzIreWxnNCtW?=
 =?utf-8?B?V0cvWFJGUzFEZEx6MDFWaVpsSkVMYjQ0UEIrOEJUZTF4WVJxQU5yZmRhUFBt?=
 =?utf-8?B?OE9lcjdZVzJ1NER2S3oyMDN3L1BFdEwrMEhISURicU53TDdjcXgwdSs5TXFV?=
 =?utf-8?B?enFMUG13R29XOE5iTkxRcWZxRTdiWjhDbVZiY1JxUHBnL2UwTEZIeTBJaW52?=
 =?utf-8?B?OTJGUWVtMnFHODYzOUpGeVJjOFMvb3Z0dUZFZDdTOGNHVktBQXh1OTE4NldN?=
 =?utf-8?B?REl1dVFMNDNJQSt2ZXBMTllGdStIT2tNaEFYZmNwUXBQUzljWk1FVDZROGc2?=
 =?utf-8?B?bDR4UGpGQklBWVdRdXhMMFpMcjhKUVFZK2dzQlhLSDRNaWhadHI5M0M0ZnRD?=
 =?utf-8?B?Z2VFWmV6cmRVdG1MeW5KVjllK09tL1VPR3QzWVVTNmtVaTNwMDFMRGR2MlRT?=
 =?utf-8?B?ZUtyNHc5bnQ0S2htZnJiSk4zUnlCcnpKbmpHOURkZU9HeWl1UXppWUIzckxZ?=
 =?utf-8?B?bzNtZm9aWFNDTTBzenFZYnB5QUpGUGo2R1F3aHd2ZkdTcmdvQnV6TmVDWGEx?=
 =?utf-8?B?bmRqdVkvNEx5OTliRXlpeWFDNndyRlFQRWg0YVUyczM5MW82QWdGekg0cjhy?=
 =?utf-8?B?aTd3aVg0cW9ySEdwOFhUQXBDWHBnYTgzN3huSmhOSTUyY0YxRFFIYVVSQVVV?=
 =?utf-8?B?azJYV1hURGRTNFh3dURXNWVpMWZFNVdlWFdkd1RCN1ZYZ3pnZThhQWxoQjQz?=
 =?utf-8?B?MUxPbGU5N1o4aXdXbkJGUy9tdTZxSlVSamlaZ3BnTy9sRDZ1UGE1MFRGa0cr?=
 =?utf-8?B?Rk8wdlkzdTNad2JhN3pEdVAvU05Wd3l2Y2hLVDBQNExJR3lYL3JVNThOalU0?=
 =?utf-8?B?REV4YktFMGtuVnFhNys3WEUrNlp2N0hMRTVlN0ZSczY2NHdPK0VjTzVQOEJo?=
 =?utf-8?B?b0tDWDJYTjd2bnJNOC9xQnYwOWNXTStrYjZsNDJiRHp6dlVqSEwySWtITjI4?=
 =?utf-8?B?cE9vQkJsdmhVeFljNVFqcllFVTlGR3pDdVR2NDBCU0ZRREwxTG1kUzFWdU1o?=
 =?utf-8?B?ZEMvUG9nV0szTExxYkRTSmtybVRqUVE4cDA5L1VuWWxvTDVyaEx3Uk9RaDNu?=
 =?utf-8?B?Y3ozRitaeTJHcUhDZnpuNWkwQkRBWDk1QVQxYjhSSHA3aEgxaEM1dmhBdmg4?=
 =?utf-8?B?ajRwTzRHa3V3SlhLZEsraVR6dkNvdWZ2WjNhNG80bHJYQ3ltTUxBYk9DRkFX?=
 =?utf-8?B?T1JNOUkvZm4vTHN6ZndMcHB2czlRdXF5b2JYdzZldGFYSFlIVlVudWtUc3No?=
 =?utf-8?B?cjdlREZZRkhFZEhYMS8vSWpCZVp5cUYvelU5cjkvQTB5Ujl2aEw3bFlDMStI?=
 =?utf-8?B?RDdEZHRQSi9PVks5OGwyRHZ4TURaRys1dEx5Ynp6bkNpT0FtNTRPdVZIckJD?=
 =?utf-8?B?b0tiRmhBUzNNa1hhTEVVQndzbDFiV293RnVHOE1wL0hKRjc4Ukk2Y21HYkt1?=
 =?utf-8?B?dUpMREt4OFEvM0N2ZjE3clk2WWhWYlROUUlrbkhYdEZNaDFPbEt6d0tLN1BH?=
 =?utf-8?B?TnpnMCsxQ0I2eTkydW1IbzVVUjFDZUx5VkpxZi96emhwYmFJVnhpYkhqek5h?=
 =?utf-8?B?cEFnSS92NmZiVEUzanVIZ1VTZTU0cTFsYURLTUpoWkIvdHZDUjI0VHk2S1Fr?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C35F1986715EE41AB36643640EDB6E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WGtkcExQdlExY3dXcFBuTzBSaTZMWEZ5L0tlRStkK01wYSthRzdOWTJ6K2Mv?=
 =?utf-8?B?ZWdvOU5jOGQ4KzIwODhtOGxWUjNObmhaK0VaQUdRVkkwOFl1bXVxWll4S3k1?=
 =?utf-8?B?clN2TURKQTR0b3BVZHZTTythNUt2RnJWNkIzMG1WNThCRUIxVzhZR0drWEk4?=
 =?utf-8?B?YjYvUHVuMHNqWjArQVI3eXd4NnkyV0xmU0VFaHlCdTVObEYrMEhQNVk2RGEv?=
 =?utf-8?B?eWlRbmQ4Njd3emppZmFhTDNSU0dPM05WZjBzZmxTTHBBMEZmMFYvOUFRcEJF?=
 =?utf-8?B?d0h4dU9zZzVNYSt1MDZaWE0xd2EzbkNHM3R5TC9manhqYzNqZ2oxNmM0eG92?=
 =?utf-8?B?Z3VoL3VTSXhzNWx1dTA4Q1BZb25VS3JDcFM0aHlaS1ZRRUZUQlhQOXYrMnY2?=
 =?utf-8?B?bmduQ09jK2NHZmxvQzMzTi91Nnhjc3J2Vng5NEQ4UWhlM1VxQU9JVnpZSUlp?=
 =?utf-8?B?MHNsSWs5MzB0M2tkcjVHUk1oak9SUFRKakhyeU1zeFhkMHIycjVXU09xYnpX?=
 =?utf-8?B?Ykw3OWdFTjJhUStzU2Z0QXlqRnJ4dWVnOGMrMXZPRklzZzRpaWRHbXZmUllV?=
 =?utf-8?B?a2RycnNWUDNXZUlIejNWYVp1S0dXajFYWkF4eTVySlJhckRqaFBqTm5aK3h5?=
 =?utf-8?B?ellJcFJCcXpXc3FObUJqUUtlRm5iWlFIQisvSUxQNVlQZFNSYkIvbUxidHhv?=
 =?utf-8?B?SHB6R0NBZ1plWVVISy80Y2U2K1JlOWpFd2gyNW9zTnVOczlPRXZ1c1RJcGpO?=
 =?utf-8?B?b3JhN2VLdU9JUVZ3aWVoR3VFOFlEMW9YcFBYVWZuQzhiS1NUaFVQNUVHTHpp?=
 =?utf-8?B?cHZibE81SURhYnRuSlBWaURhaVFuMlZwd3ZncDRxbHdUTjhVY0orOXBBRVhm?=
 =?utf-8?B?TERWRCtoZkY1TnRIZ3ErT2lJRERXaWpzbFRVRVdHMFpWeWxESFNNVzA5OWNw?=
 =?utf-8?B?NW5vWWV6alpnQm51UUYzTlMvV20wOXM0aWlBUWhRZjBZUVZYRSthL3Y4RTVT?=
 =?utf-8?B?cDlhS0RnYlhiUXJHMjB6Y0ZLby84ajFieTJtRmFTTldGUDBoNHAyZVcyV2h1?=
 =?utf-8?B?S1lVNzAvZEhPazlZSjY2MjN5YnBoa3FrT1JQSzdKQjR3UjZGdFlkYkVoMWxY?=
 =?utf-8?B?UG1ZSXJXTU9NNGtaMlYybEQyK0o5ZzdRbWlDNmo0MjByb0xuSFlwemVxVE1k?=
 =?utf-8?B?MTljWUVKenpKK2Y4NnpRS1N3c2RmUWFFVkZFcXN1dmlFOWxRZkh5a2ltOXhM?=
 =?utf-8?Q?9np0zuaiKYgdRmS?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d12ddf-9d64-4872-89bf-08dbb469cccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 14:57:50.3420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2wc7oVzJWZyCXn/BATNkWI4Pfypymgc839zFprIY55yNf3TtXsZ0KEmdzjniAfMrk11AyoRQWFItr5Vjo3cQ8UFiG/hUvLJmT5OYmRJGec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7748
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDkuMjMgMTY6NTAsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gV2VkLCBTZXAgMTMs
IDIwMjMgYXQgMDY6MDI6MDlBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMTIuMDkuMjMgMjI6MzIsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+Pj4gQEAgLTMwNiw2ICsz
MDYsMTYgQEAgQlRSRlNfU0VUR0VUX0ZVTkNTKHRpbWVzcGVjX25zZWMsIHN0cnVjdCBidHJmc190
aW1lc3BlYywgbnNlYywgMzIpOw0KPj4+PiAgICBCVFJGU19TRVRHRVRfU1RBQ0tfRlVOQ1Moc3Rh
Y2tfdGltZXNwZWNfc2VjLCBzdHJ1Y3QgYnRyZnNfdGltZXNwZWMsIHNlYywgNjQpOw0KPj4+PiAg
ICBCVFJGU19TRVRHRVRfU1RBQ0tfRlVOQ1Moc3RhY2tfdGltZXNwZWNfbnNlYywgc3RydWN0IGJ0
cmZzX3RpbWVzcGVjLCBuc2VjLCAzMik7DQo+Pj4+ICAgIA0KPj4+PiArQlRSRlNfU0VUR0VUX0ZV
TkNTKHN0cmlwZV9leHRlbnRfZW5jb2RpbmcsIHN0cnVjdCBidHJmc19zdHJpcGVfZXh0ZW50LCBl
bmNvZGluZywgOCk7DQo+Pj4NCj4+PiBXaGF0IGlzIGVuY29kaW5nIHJlZmVycmluZyB0bz8NCj4+
DQo+PiBBdCB0aGUgbW9tZW50IChvbmx5KSB0aGUgUkFJRCB0eXBlLiBCdXQgaW4gdGhlIGZ1dHVy
ZSBpdCBjYW4gYmUgZXhwYW5kZWQNCj4+IHRvIGFsbCBraW5kcyBvZiBlbmNvZGluZ3MsIGxpa2Ug
UmVlZC1Tb2xvbW9uLCBCdXR0ZXJmbHktQ29kZXMsIGV0Yy4uLg0KPiANCj4gSSBzZWUsIGNvdWxk
IGl0IGJlIGJldHRlciBjYWxsZWQgRUNDPyBMaWtlIHN0cmlwZV9leHRlbnRfZWNjLCB0aGF0IHdv
dWxkDQo+IGJlIGNsZWFyIHRoYXQgaXQncyBmb3IgdGhlIGNvcnJlY3Rpb24sIGVuY29kaW5nIHNv
dW5kcyBpcyB0b28gZ2VuZXJpYy4NCg0KSG1tIGJ1dCBmb3IgUkFJRDAgdGhlcmUgaXMgbm8gY29y
cmVjdGlvbiwgc28gbm90IHJlYWxseSBhcyB3ZWxsLiBJJ2QgDQpzdWdnZXN0ICd0eXBlJywgYnV0
IEkgL3RoaW5rLyBmb3IgUkFJRDUvNiB3ZSdsbCBuZWVkIHR5cGU9ZGF0YSBhbmQgDQp0eXBlPXBh
cml0eSAoYW5kIGZ1dHVyZSBFQ0MgYXMgd2VsbCkuDQoNCk1heWJlIGxldmVsLCBhcyBpbiBSQUlE
IGxldmVsPyBJIGtub3cgY3VycmVudGx5IGl0IGlzIHJlZHVuZGFudCwgYXMgd2UgDQpjYW4gZGVy
aXZlIGl0IGZyb20gdGhlIGJsb2NrLWdyb3VwLg0K
