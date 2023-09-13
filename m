Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8DC79EBD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjIMO7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjIMO7Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 10:59:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD5B3;
        Wed, 13 Sep 2023 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694617160; x=1726153160;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=66wRKZTCiSWNpFl2VvMOpvV4US8Yj734kMhcmsn0TQ0=;
  b=a9a1Qh1R5C/mcuw7MHcaTCGGp03aJ/7n+xG1tR4glQ8HiRKqdzUDXkNd
   d/1ZLA1pgsz9Rv2hw/yCT88vovu8Hy1elg+qV5t2gmjWfjb9nB6i99u96
   ++uQaRLLLkePYkNDfz4tawWpBDCJpdH+JxxbMktuwTRzKWag6l0QDmVk7
   UTjdEWehzLZbr9A1ymqZlbo/uYLkv07Z7YYRzS7jcCdTW9N4jVcH/uz9J
   kOFuywRyTWOYMKDaucnHyZP029X7cx7HMniijtTXNu4uuesQkOkaXSBM+
   pQlpgKbAHhR1AGjtqFREeNdaO+PFG+duKTQ+VSChgVgdzPEPa38l9bgQ8
   w==;
X-CSE-ConnectionGUID: erPuwmbdQEmcvRreQAic1A==
X-CSE-MsgGUID: kMtalzgdQ4CtWCgwyMSf3w==
X-IronPort-AV: E=Sophos;i="6.02,143,1688400000"; 
   d="scan'208";a="355945591"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2023 22:59:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR8xsMZW7svFTUZKv+kpUH2SGAvUoFWxnK987BtxZaIT52xi4lNpHpvx5t0WyR4FWdAADiFbBlBlFY77CQgCIL8g3mN7U0j6RZHRcRsYed16HAb+VxKscBg8t/haGZrLL5ZrA9SIZrlMfgN+FhDvXuH69sMJTXqK/D9dmnUGIdfX9mRKPBCqHbk4gklLnAJu57Rl5SU4L5ARkTJrTPL4hZZ3sztx50m/1+tGoL462P23YQqNaLuL/nc2wwSk6qYcgmi05DBDLagYVBpB/1SnFu4XBbmJPD3/pQfk+mSbZ7YOltZQ/B9/mHFVc22/YV1BM6BnMTOpN2Tz/J8GfilNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66wRKZTCiSWNpFl2VvMOpvV4US8Yj734kMhcmsn0TQ0=;
 b=OOCUXugIIA+gRAp8YqBCnhljupp3Lapwp7MonSbM4dew3avL2pl4CIteA7IkOvsPv448cux6R5lKpkhglre9lyDicX4y9UuaFBq//xKMfaOgS2RJHQ81UrvIQfPlUS4+8chhXuq6kG+i+XDoSphYNy3GcVPonpsZY3cmIQ+tqiQT40dYxxEnh9tXp+td0wsa9i+k8Yur8KM/X/FBE4vXIO/KLlmGXqBxxBHruGlF2j8yXC9tT6wsjj9uH5qTUnUpNAcuEOEw/R8T/wmcMLbZ0OgPmxW5+4E516DEZhHlxKJ2dnylvn4cqsvWipWCvDvlkdAUPpfoc3S8KR3A18Bp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66wRKZTCiSWNpFl2VvMOpvV4US8Yj734kMhcmsn0TQ0=;
 b=raRKAuXJLfiHioWVXCBJw+WWXB/vm72L/P1kr9X9QdyFH8ORofC/JAWfsAKRqi9avaEh1TATpbmklhv1JqMlOBAynFCerJPzshW2lx7+f/9n/kFNwc3xblHTp4ZlY1E/IDoIlpbv+VVWIG/oO9pd3zWAqj7ii4vnoDVCuE5hg9g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7967.namprd04.prod.outlook.com (2603:10b6:408:156::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 14:59:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 14:59:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 07/11] btrfs: zoned: allow zoned RAID
Thread-Topic: [PATCH v8 07/11] btrfs: zoned: allow zoned RAID
Thread-Index: AQHZ5K7aGYN+5dE86kSpOT2UAi+96LAXq8YAgACU2gCAAJnuAIAAAdCA
Date:   Wed, 13 Sep 2023 14:59:17 +0000
Message-ID: <c6326bbd-898a-42f8-a889-53f301369d61@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
 <20230911-raid-stripe-tree-v8-7-647676fa852c@wdc.com>
 <20230912204906.GH20408@twin.jikos.cz>
 <27b68e26-d6b7-406a-9a55-6f298fd82ad2@wdc.com>
 <20230913145248.GM20408@twin.jikos.cz>
In-Reply-To: <20230913145248.GM20408@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7967:EE_
x-ms-office365-filtering-correlation-id: 0ae1e205-576f-42b6-bdc4-08dbb46a00f0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ym+P/tfEkg4kTIjx/ZHjwXyDpdaVGd1COMB8pkSDAFm9ukrEijkw5Kn7fsL1k+h5vW3NhrFEHGlunY/r2VL4DAQUhVpY/eoxWX++ofJBkdgfg6FvMjU1MVp6bQMPCX3B1+bf8aPhweqd4cQizQneSn1nAdhHaMZiH4H7F2tF05RB1J/12cYyoJA3NL7f6acehsdS1w7/ppSEndkMXqn2+DqbYZO6tJ9F1ukLz87TRhX6ikL4PwmK+rsO8CN3Aa2dnd/OXvaADXvG/+fTb9+0Udhnzg3q+ajl3R7qxfPRm+XqGWIdg+h4VDGvHywosR7qP1Xs3Lvyhg6n2R7a/KWjvm0WrZRL10GO/igWPaOoaTz8rkwGElzxpoHmOEjibejElUK5C3GrmXhzkkAn+eXV9hfRv5msyAhsTOPBb6MQr/QmvsYchR1tgoIZbQZ/LUMagdC7S8Xt5Pq6LJlcidZB0kO8f0OjlGZS6HCzVE9R79W8WAOEdLYRqOmb82ddU1N3S78NVsdFG4F0tKmzf3wkHoGPTQqJExXoYGDD+97kt4OFngkxyaB69dR9kGIDh4FI3VwhHcIzAQVevH1mS+BykGl+t7IpljSZCU1MpBDhhqQlhdSsz1WYZtYIl8C+gKgBNvxEfFh0K3DOctNi7Vi+i4uweWPU2qIorm3TTGIl1Qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(36756003)(31696002)(86362001)(122000001)(82960400001)(38070700005)(38100700002)(966005)(478600001)(316002)(6916009)(66946007)(64756008)(66556008)(66476007)(66446008)(54906003)(4744005)(76116006)(91956017)(2906002)(53546011)(6512007)(6506007)(6486002)(71200400001)(8676002)(4326008)(8936002)(5660300002)(41300700001)(31686004)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGxaYkp3MWtlNUhWdXBHREhXMUNKalpGNGpjRmJJenhmUGhhc2l0VlYvOXo2?=
 =?utf-8?B?K3pKVHZpVk44VnV4dlJEY1dSNCt0OHA4UFFSUTQ4QksxdmF0dy9aejUyVllH?=
 =?utf-8?B?dk1nNkh4RDUrQWxHMXMrL2w4aVV6YlNQdFJMYlhGOFphZGdPUUZzcHFWdEJR?=
 =?utf-8?B?ZFFSMXZHWjdpSlhaeEl1T0IvTWxaTnZRWTF6TndjcGhKR3Fhc09vWGJ2QnhJ?=
 =?utf-8?B?WGNJZERMUEhsRmxMVE5NY2dobGVycUEzR1dWZDBrelBXSDZvY0N5K1VZanl5?=
 =?utf-8?B?Njk4WGZBck5vSStPNVFjd2oyTUkwSzdESmFUNy8zZEhwRzFsN0VnWm12OE1Z?=
 =?utf-8?B?STdRaGg0Y1IzMTBNYzRiQTIyTTlpTG4rWlEyVDVKUWREUWRadVpqTkpVY1By?=
 =?utf-8?B?enBvdFVXRGZoVExaanNjS2NIeXpzWlRSRnZmVlA5MVVLVUVXMXcwTGtTaldl?=
 =?utf-8?B?K243OSttM01xR3RtZHFVSllhd1Z0MTZGaWdsRDlnTUJyZ0JqT3FaSEhvK1dD?=
 =?utf-8?B?L0FMOGtqQWVKMElLNU1KYXR1NWZFWHVJRE93TXBsTHFpVDNHTUlPK3NzNjlB?=
 =?utf-8?B?ZXdzZ1pISU5lc0VNM0JPSHp5MzBRa01TUDJvV0ZPajYrdUU3ZnhZRmh4UE85?=
 =?utf-8?B?VjlPTlhsRHM4YUNGa20vcVVqZGNnOWNIQURVd2ZWakZrTS9jTVpqa3JRMWFi?=
 =?utf-8?B?UDBDNmY0bEp4TjZlL1RsenFWSkRydGVlbHdGa0NKZTFUVkdzeU1jYUlkRENX?=
 =?utf-8?B?R0pmQVg0SldPblpkaFZFOU5nSkhxNng4ZW1rTEdKZGVPMGk2OElsU1RsRXQ5?=
 =?utf-8?B?UnJPVDZuYnFHZGd5cmVKbW9heG9TT3BlSEVSVXRJVW4rV2NLdzgrTlllV3Vi?=
 =?utf-8?B?RW1OSzkvNGZvbUJNYmtHRlRtVWpHVk1IK1JzWUx2RVZ1MGZUNnVVOXZMODNk?=
 =?utf-8?B?QzNCdEwvelMvbkwxY3VIdmtjem13VjdwNk9FSHNweWlUMmZ2TjVZTjhKaHpk?=
 =?utf-8?B?VkprUURjSTJyWE1PRVhGcEdLLzU0aWlCWWxiOEp5ODE0RkFDQkcyUk9hQW5E?=
 =?utf-8?B?ZDVKR3o1ekZMeGZ0Wk0vTVRxSzZpbVFBaXBjMFRvSm5PNmcrU0hiUkd0LzEx?=
 =?utf-8?B?MHhZZ1hmN3pqWitLMGNFa1JwS2QvWEszWVJ1QWZLTWtKc2ZMTHE2aUtISDVp?=
 =?utf-8?B?VFN4U3pPVE5OcVR5R2FramplenFWUmpQYllTNkNQdk40ZVpuT0dKMVFlSW9Z?=
 =?utf-8?B?TlNCTG1JQ1ZRcjFDYm80NWVxVjh5ODRmZ3IxRjVQYzk4WW92ZEtmWTZiSy9L?=
 =?utf-8?B?ZEJIUUU4WityZy95dmYrbitrMGorMXo5cS9nSXlkOExsWlg1VEd5U0JXNFYx?=
 =?utf-8?B?QWxPQVc2SzJHQ25lZ1pEa1NpTzVaSWNSaWZtU0t2MTJjb0s3SHRhUEd0ZFdM?=
 =?utf-8?B?aENibmVkTUVBOUVRSU9JUTVNZFBVZEsyaFp4UjhsYjljME13Zkc4ZldJdkNo?=
 =?utf-8?B?U2Zia1lkSWw0YmNOdEpsSnV4ZE1qSkNFRFU2OXRXNnUwYW1QQ1lvcEZnZVdD?=
 =?utf-8?B?R0dkTmxmd1l6M2tveFhFQUJqWGlQZGtrODI1YzFEQS9GWGU4MXFGVE8xZnhi?=
 =?utf-8?B?S01RVk52RTJkaHh3aS9vZU5BcG92YTcxNjIyZUlxZW5Tc0NzdEVBMS9MVjVU?=
 =?utf-8?B?ZnBydVByZXlXYUVrWWQwQS9JQ1owNWJFMlNyRkhWU1RUZnpobnNLSS9SMVpv?=
 =?utf-8?B?RkViWVorVnBiWFpublZqZWZMUjFJMExrcjZjZnViQjRmNlg0cHc0Z2FjYmZE?=
 =?utf-8?B?NWw2djNRb0syRlVQUHE0eU0yejJQMHFNUEhwQWFEa0JJZXVlV0xML3hoY01U?=
 =?utf-8?B?NkY3NlNnMVcxcHh1Nk5GTUE3V3RWRm9PWjJuM0Q5amo5cVJlLzF3b3RzeXgr?=
 =?utf-8?B?MkJzYWpmVVI5SEdlQ3dOZnlTa1lGcUk2dy8wbFJxcGVkb3VxbzN3ekFtNW9Q?=
 =?utf-8?B?SjJKekJaQ21POUhmWVpjNzc2WkNwRDFMYm1qSHdGczNrQVBJRHVKVURzLzF2?=
 =?utf-8?B?WGZhc3NGTzBuMTRkWVRBS0NpaEFiNUJ4ZW1PVFM3NFpHZGYzbG53Si90QXJw?=
 =?utf-8?B?RDFPQkRkTTVHeE4wbXJkWHE0d0dBYzBYNzZ3ajlIRjJKT0o4bFlFa2Z4V1Fn?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C08222E1BC5DBC489624EEA103A7717D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UTRoNkNwR3drUWR1ZEpBYXVTckVRWVhGZFpvUzdqSm9kRE80QmQ4YXNHYkR0?=
 =?utf-8?B?dVhXUHZCeTBsN0JJZkpPWFpWS2dGVDRNcmFVZFI2aXRXVmxRT1EwQVNRaGJD?=
 =?utf-8?B?TFNhY0dBTEVZQk4wdlRPQ25yRm1maVVKMk1OVW5HTlBlMTZJZlhjR2hwdFE2?=
 =?utf-8?B?Z3JtRnhaeHIrSVh4bis0VCtKSUVzRDFtWW1qMGx0ZmIwM2dxTVk5MTVKL2Jp?=
 =?utf-8?B?Y3poT2hiTUhYclFocURDbUUvaDJLeFM0N1Arc0ZLcG1mNUtrV2RJeXkzamsz?=
 =?utf-8?B?cTZkVklJNkN0VmNLd3RKNnZHYUJVcVNQaGFjbEhwRi9udjVJNTd1ZjJwQklC?=
 =?utf-8?B?ZlZyM2NWc3hCMi9KRkJnVmE3eXY1NUNoenZzK1hLbFhDc3lMYUdjWFdoQlN0?=
 =?utf-8?B?dnhNVXBad1cxeHhraGExTFYzMk1UVytnMDFqNEVYZVdDUk8yZFowcmE2d29x?=
 =?utf-8?B?Wi9EVUxpMXFBZGdTR1J4RTB5TzdIRzNKWHgxTTdzODN4NlZmalZ0SG1kRWlh?=
 =?utf-8?B?NUtISUhZYUl2MWtwR2F1SU01Yjc0VkFjbEcwVDdmZEpLdTVkUjJReUgzbUZw?=
 =?utf-8?B?YjN6bFJQdUJ0di8zdmUvNSsxRmkzMDUrakJYSHFxV1R4Y3VURWw1QkxvV29P?=
 =?utf-8?B?cFFFL3c4ZWcrRlZpRTREUTBXZWI4NnJxUVZtRGd1Z0NJa1hZa2d4SStCcUor?=
 =?utf-8?B?Mjk3TTJQRk5JT3VHN3U2dkw4TXdRUVNBSjNPZDFYaWdpYTI4TG1CZTNReS9r?=
 =?utf-8?B?bTMyYkI0SGtSWmVTaktHaXlPVENTTEVCQzNZellTRGdvYUZYMWxXTmVsVXpl?=
 =?utf-8?B?ZDdZRThYYW5MNXpCOWI3cDZCWnBHRDNWTjIySzZlRC8xaE1Hd0RBcXhzSmJB?=
 =?utf-8?B?NHVwc1FxdElyMERaYjFTbC9qdWY4NDVHUVJNdDd2aExmUzJkSTJ3UHhONTRt?=
 =?utf-8?B?b1lwL1dFYWtscDFJYnpadVk4UzF3MlgzZ3o0SE15VjJHRDZhYU5INFlVY2ZV?=
 =?utf-8?B?UXcxZStkV0RRandhTElQdzlNeTBiZEVqOTFVZm1iVEpSbWJvcjdYNCtlbEsr?=
 =?utf-8?B?dVdyMzhOdkhQUllYN0VWNmRWd1NKY0lmZGwvV2Y5YmhOQVJzdStQTEdiZE94?=
 =?utf-8?B?Tm9KV0RkQjZJTmJoMnVIM3ppQWc3TWZEclRoWUUvOTNteG1rNmtLOFAwUUF1?=
 =?utf-8?B?OTZzaXV1M2xTbDlXTHlmV0htemlYZU1hTWs4aEkzWDJkOXJ4clltWVFOajRM?=
 =?utf-8?Q?HoPbbvTV4+QlEgz?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae1e205-576f-42b6-bdc4-08dbb46a00f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 14:59:17.8354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ieMGtuGLgnICJoL7bFROB5OG3JQhEfEJupDO15WpMhG8eWR6Gb2X7LRwqsm8FFUPDHcMoboRFCPKt8FRW4n2l7okHk4g2YmjEjVd2wFrR9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7967
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTMuMDkuMjMgMTY6NTIsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+IFN1cmUsIGJ1dCBJJ2Qg
bG92ZSB0byBoYXZlDQo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA2MDUwODUx
MDguNTgwOTc2LTEtaGNoQGxzdC5kZS8NCj4+IHB1bGxlZCBpbiBmaXJzdC4gVGhpcyBwYXRjaHNl
dCBoYW5kbGVzIChhbW9uZyBvdGhlciB0aGluZ3MpIHRoZSBEVVAgYW5kDQo+PiBzaW5nbGUgY2Fz
ZXMgYXMgd2VsbC4NCj4gDQo+IEkgc2VlLCB0aGUgcGF0Y2hlcyBzdGlsbCBhcHBseSBjbGVhbmx5
IHNvIEknbGwgYWRkIHRoZW0gdG8gbWlzYy1uZXh0Lg0KPiANCg0KVGhhbmtzDQo=
