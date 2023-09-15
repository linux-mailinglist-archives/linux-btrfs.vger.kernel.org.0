Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E77A1B82
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 11:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjIOJ7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjIOJ7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 05:59:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29763C1F;
        Fri, 15 Sep 2023 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694771860; x=1726307860;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IEpkYVIortKMZQPuNivRCveNzIaUA9gAPaa1DgPM16s=;
  b=lOAEMO+t12MoiOo5JkXlRg4E/I23a2CMruaiWzhVgYb/+uH1td+QAOhi
   RuqREHL0Jvr2OUMYnk1cAt6z9lU8nAIlNBzVWAniXiOerJZXXt58iYNJe
   8DJ5oUCn5iq3efzrvKb4DtHpqnmizrF0Nxz2DKK8e5VOOXD37m+rzAbZ4
   GLqCKJbMwVyWmPy2iUne3U428Xb2Mwftlog7OdZ2Y07COzXX8ttcgbKEq
   QbvBHtV6TwESMB875EUZMcThBhoGGoF2TzmWPjObabwfIOBVajIdy/1+F
   CgwmcIOXRzQ9IcvQkzEXuiN2iqv6wyQfu/LEoMpty53valjNi9O8n5mGo
   g==;
X-CSE-ConnectionGUID: o4uh7WpZSnmh7/sGtaFR/w==
X-CSE-MsgGUID: Ys6Kq4BlSXOnySiTW9PlUA==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="242263784"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 17:55:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5O3cVdwBt1I5qQ3hk+7w5UvkdijmeaFGr5OQvufPz1e+TKDxP1iXIXkHDwG4rrZgR3yteJ2WzvlLMYM6KSkJYjPeWg/R5d49DTGVDjIe/G/COHyxdJa3T3mLeMu4gWzw5pukvnikDdY1mzmpx9XSq5yFyY1y0VBaRAKPU5Yj6clu4tq8sOZ5d1XUc7Sq47Px2yQWnSGpqOHWowGi3aLvzY7J/VjuzPdIA7GVHTK3RJ3551w1+RpMEgfvVA7Wj09KPRKHFRopm9qDaZVH12ok6befRYGrwLI8TtAF7gTquOIM0eEUWlZXaq4buFyhhb9B6pG9YLSocxgpbsXZghIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEpkYVIortKMZQPuNivRCveNzIaUA9gAPaa1DgPM16s=;
 b=ergd5sbVSEL6lISwEXxAgGwgmJ+D1XAIH2yAOeMbYOVSSD4X8e7ZvGMjAPKidfv2HMfkHCYIZ8nIRSxZ7cCsKuilskrVrTXMrKeCjNKtdje26GVq0HOULs8prgu1cted49biRZwiyKGRefqzqf+/Rrk4ul91RArrG+vtJHyuNdqem9hwAetGPMTZWToFvhyma8KooGceoVyv7hju2RMkZFOa79N3X1iBdVh1OkwU4RGCqRwA5wmXVnZWqcA8pDXPqBOgT0UqzAk0ErxAMuu3wVqPVxgM+K5YiPMIbtjEfnvRgfO/tHDitw5F3QyLqRHOYdBTbphXEn//e04+z0sefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEpkYVIortKMZQPuNivRCveNzIaUA9gAPaa1DgPM16s=;
 b=RYZA0px0xhdndF5CwvrUtAkp8x9lBYA11Q2De5Pedo/ZipoSqCL6Ggf0AnsSyyB0ByF33AjxjMYyxSkmHFjVsg6sF6o2Ykhqb9zQae13Lmlz6GSXn7oPrbyLjs3kk8K3YIVUuVi0eR+LUrrpzYdjSJTS1O3Z/qs/HMB+EvThDvA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8190.namprd04.prod.outlook.com (2603:10b6:408:15d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 09:55:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f694:b5b5:8e42:b8f6%4]) with mapi id 15.20.6792.019; Fri, 15 Sep 2023
 09:55:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Topic: [PATCH v9 01/11] btrfs: add raid stripe tree definitions
Thread-Index: AQHZ5yWFR3MOJvjDnk27U5ab5k1D2LAbBxYAgAABMICAAJ76gA==
Date:   Fri, 15 Sep 2023 09:55:36 +0000
Message-ID: <c85e00e7-e9d6-40b0-8bc9-7d966bbd1026@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
 <20230914-raid-stripe-tree-v9-1-15d423829637@wdc.com>
 <b1330370-3261-4845-8a1b-f639ce7fe6b1@suse.com>
 <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
In-Reply-To: <3e1ed108-44c5-4616-922e-542524c0657e@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8190:EE_
x-ms-office365-filtering-correlation-id: 9ca65ef2-2c54-4a07-34f3-08dbb5d1e8c5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UkfDYXryS15+84awAyAj4yLg5oLbKB7oW4ZHMBGCO4+jPjwoPQ7u617No8sPwhNFNNMaj8J2pOWvdCXG7Xt1pgGmpKzrRpqI2azcmaUBrujn/eqdtrRH/WDDjkfB35UZp0XByVTtCqln/vNIzStdtApOXbCD3Ca9CmmBabIN8K2QZCvsefYLcRjwsnxe46DUvhSFg3aAgpQ9rEy+N4aULqwP+AjzszQqe7TKi4Us7s3nHLK72gl9L4qfvyzOSDtPd7jWLLUOcP6y9AihjAH8edEn0nyhR2U6JnZiH3gGhQBB2I4QqJYIC7oWA54db2ieDb7Uz0QZqWjBGVCyTCKpyiNUa+uEEYXOWo/0bezcB0Vihb+PXfJbBe/c0rNSGqQ0TLUVuPXxkuH0M/xw3AWi7hfSsQiSxaEc/DiohiIX4r3F56MLDT1YZdP8eY/uffxdxSOxfh+xuX3QAoCX7YR5F/zbLEUvqV0C2WSeRZudUKX544kjQJys0Q/GAxllH8BGh0WFM+H39PfubKjKQkzQGh0LxrbCPSWMiROa59wMxnMVTKpE7XGKMONikzBCjLFU0ls5sCvTcsYurKPmHEAKq3IrHTa5P+dsOQfiX+dTQ7sYPfIl/R8JrytMO88pXppCX4sHDflq9V4GR36F+KUkTLaLdHCx/z+LpfdNABKIHcys1mv4jX2+KXMf+eqoX7kwMdFJzJu3ohs56CjHlpJacQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(31686004)(71200400001)(6506007)(6486002)(53546011)(36756003)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(31696002)(2616005)(26005)(2906002)(6512007)(478600001)(5660300002)(110136005)(91956017)(41300700001)(4326008)(8676002)(8936002)(66556008)(66476007)(66446008)(64756008)(54906003)(76116006)(316002)(66946007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1dUbFJpRjQvbWN3NzF5Sy9SN2IrZVVieGtmTzl0TUs2NUtmbm9VMVlqWnVJ?=
 =?utf-8?B?aUF3S0lFY2Z6Rk9teENTcVkrZ2p1QmN1cjFYc3FMc0FjcVFmNzhmNWpJTEF2?=
 =?utf-8?B?UTZyZVdrblVlNnU2cFdpaWpCSEk4RXNhZlp1VGdXWU5SSVg0S255dkRNbU9S?=
 =?utf-8?B?a1M0cy84eU9IWlEwMy9NYlRFYW5ZQzloMFR4anRhMXBYelFkei9mV3lyc1Zj?=
 =?utf-8?B?S3NsbGcrMnVmSlQ1VU16LzRxSXRLSVJEWC94WiszanY1YkpWbE1PRnBGSDFC?=
 =?utf-8?B?M3RIODFHT0h4N3RzYWlGb0pmZ25kTWtLc0owMUttendKMWVHU01Hd1FpUG1F?=
 =?utf-8?B?R1NQdUxMTWt1YTZ3K1kxUFBTRWtaTkk5TDFsV0hyVFViVHlHMXN4cTFOemxE?=
 =?utf-8?B?VG9TTFMvdE92clh2VEo2ZnY4NDAwam4wQTkyKzhEQWY0TXJrTG1CWDZ2bDNm?=
 =?utf-8?B?Ni96aG5OOUNkUHczYXlLd2xLYmZ3SkhmdGRnQzBselpRNmpPRXlaUERGNWJJ?=
 =?utf-8?B?aXFORWFZRnp1RS82M0FlSTZ3UStBSElpUURlankzZUZOL0dvcUVXVmZLN1pj?=
 =?utf-8?B?QmRMNU9yV0FXYjA4aGZnY3pGL3FxbGZvb20vMWxSTFVOb2VJR3NkYkRSdVZ4?=
 =?utf-8?B?eER6ekhnSHEyZERQcS9qUUVTbVZoWTBoK3pDUENtZzNFazExTjE4VnJqSkNt?=
 =?utf-8?B?Z3R4d3VsZUlsOEFCc3FTM25LaEU2Q2VtUndRU3o5cWdYWHlxSklweTNyQ2ts?=
 =?utf-8?B?bXZLSEJBbXhOeFc5MEV1eEl0eGYrUHRGQ1ZBUFJlUVNTYk5OOGlHT1huLyti?=
 =?utf-8?B?QkhyYWJvU082T1g4QURBMkhFbGY3SXV5bkYyZzJzYjk2WWFua3BuWkRPSVVC?=
 =?utf-8?B?bGpqSjRESUYra1FvanNTb2lMTkYvZ2RkanNLV29Lak9kMmlJd1l4R1JrMk9B?=
 =?utf-8?B?YmNvWkVtbTF1YS9XNm9yR09zYmtaTU9xQ2IrdGFuTm45ZTVWb2hUZm1yWFc2?=
 =?utf-8?B?SVU2Y3l2YmRxc1IwQjJVcEo4aTNPaGcrL0xqNytBdjVvbldqbDlRditKNXhy?=
 =?utf-8?B?VmRjNTlGSHUvQXlPb1YvUy9qajBGNVpvbXJUSnQ0OGtDSHJyS0xob1cvRk1h?=
 =?utf-8?B?cVNMWVh4QnNFYW94cXhSODBHcmU5YzQ1Q21lLzVwNU5hU0QzRHFVWkhFclgx?=
 =?utf-8?B?bGdCZk5GMEVlTWJPTEp2S2x0M0NlTktoRElqV2xoRXltUXdZWGlWbXB2SmZC?=
 =?utf-8?B?T2o4NzNLelI0aFdBdXNRTkcrSmRmWkxCaWtvcERlcU1BS00vUkFkdm1mNUVz?=
 =?utf-8?B?NmZPRjR2bWNIcVRra25Uc2NJaW1ReUVJL0tPN0hvVCs0dkY0Ty9QeUFQYXhI?=
 =?utf-8?B?T3lCQkEvSEY1djJGQ2N6ZzNoQ0hwNi9NT3VkaDVpWDAwZDBiL1JLcFpFWXNJ?=
 =?utf-8?B?MmRqVUhMVi8zZVlMM0hyc0dyOTU1eXFnRlhlV2dZcE9FYWpuWFkxQUkvM0cv?=
 =?utf-8?B?cWF3ZjNWVEZnd2tpenNQWncxeWgzaXQySzRCblNMVmRJVG9wOUZEem1VbVk0?=
 =?utf-8?B?Yk02MDdqSU16Tk9JbzhKblhsSW81emlqbU83RlhYYjZ5Q0N6Mk9WdEZsa3gv?=
 =?utf-8?B?SlFiUmJjNEdLVkNQcHZiSk1FODF0UDY4T1NzMUdMREkwT2d5eCs5TmtvcVVy?=
 =?utf-8?B?UlBmdWNDVUxmUlorMGxONVhMTUwyeGJYUUhYUk1IM1puUmFCQXZ4SndKdm13?=
 =?utf-8?B?bEtnOC9kRWd6MTlERjZ6bWcrVzkzSHJrVGltUk1GbXM1YTdzaldob1R6SEJM?=
 =?utf-8?B?anNEN1lCQTlLMGhVWE9jTkt5c0xucXJwSldmS2MxQ3c3S1NPc2lncDBDN3c3?=
 =?utf-8?B?NURnOEduU29sTldqYVova0M4TWdkemFqLzhBNEFHREpoNGNmaFc3bHMvRUlN?=
 =?utf-8?B?UWZLNmhQT1ZqRVlRTTNrdnUwY1lrdVpqMmMrQ1FqRkllV0svK2lFcXR5dUwz?=
 =?utf-8?B?N3pkZnc3UGdYMjJkbTAyV3VoS1pPUlNYWG1oT2Fra3MvT05hNkFlbTlTUXBS?=
 =?utf-8?B?ejgySkxud1FiVFV2NEJnRDUzZzF2bHdkR2VXUm0vTXZSMGJ5cUh5a2RBR2NI?=
 =?utf-8?B?c0dTUTdFb29NQXBVaWFIdHhLdEFnQmlManUyNi9uN3o2eXNuOFVQSzFldnZC?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB1611A9EAB4874696F30CFD606F42A6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4tPpe8eDhWI9fuYaBNt3rI684uXG8fPCEPZL3TOUNdsebpj0zPVDwIOSnucWBk/kK33KsI7H40c5KuNlZTE3m8a6SG5rpf8HkrDEJKUn0rzXiN2gAUYvrudZ1I8QWI/nKWMI7Xwx8110aRX8NcySfRkNZVw6cItPnNyNROOjsedgp9KkcRHtNK8xZH1OeHdDgZzQUtC4d2iP2S5bpymGxNP9v0nomM0hCWP+uhvqYkguDXEKK2bv22uO+qDckRtA4IBgU3zkDPMPEnEnyJXjHKaXGlqzQ6m13RuR3Q7nfez7zsoCHiB195vzuNGVkLyu75R5k5QXv3JFsXof83WRCjP+a1HmEf8JF6bkQ7gOc10pkDqEAS1ZQw7M+cuOhvdVMNEKFb5xir1kls80b3WdontJ+AdZMfiu1KKjLyKnYYzCZ3KBM+b+Y353fkTtlTMYevU7oTIRp11FB+kc2zet47oXPzyZlTmNZCN7lrsA4/PL3qdc3jmcqWdQAEwrHBNxSWvz8HCC8k5bDGAay72LgwlRYriPX5z6wmNZPfF2+9gYKsw3pF16kO1IhhAfwE4Umv8UAOBUr/801FrPhuT6bdbPhoIU2SLX7qGuMTcHpeWq7MH6FDRBL7AougxBR7DpE2VHG3ZsI/H4f4gb18kf6ehSlYarnG/8+nSMDvgY5nE0YAs7PPmUoob7z8Z4DEdQpm9h2PiI8s3qyzw8jQtWwoysLi0wMSUS7+Uix+yEeeNqI/mp7OjZ81+uDniLpY69W8xiKh53esvuyW/BBdjm62ZXpl1FqhBXSvVytIIX99FZc+0Rg/F+Pdc+lq9dFb3Zamy71U2/UEPu9V+AyPkhMf5KBa7VnDHBT/Lt3y6FE4rLTTb2Kv4/mw8mun3Px796Z7QVmoog5pFyHtEvWsa6aqMoZ6OnbtV7ep8N0WS+2ck=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca65ef2-2c54-4a07-34f3-08dbb5d1e8c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 09:55:36.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLByBsEW53fUGpqNj5UACiMBpBQvpzCXIGqeCZ0HkJqNGmxgmsCMpc8x+oPzhEmrkC2nUfBmLTFS9kSzppTE9PanVr3mfroOIu5JCaMohSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8190
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMTUuMDkuMjMgMDI6MjcsIFF1IFdlbnJ1byB3cm90ZToNCj4+PiAgwqAgLyoNCj4+PiAgwqDC
oCAqIFJlY29yZHMgdGhlIG92ZXJhbGwgc3RhdGUgb2YgdGhlIHFncm91cHMuDQo+Pj4gIMKgwqAg
KiBUaGVyZSdzIG9ubHkgb25lIGluc3RhbmNlIG9mIHRoaXMga2V5IHByZXNlbnQsDQo+Pj4gQEAg
LTcxOSw2ICs3MjQsMzIgQEAgc3RydWN0IGJ0cmZzX2ZyZWVfc3BhY2VfaGVhZGVyIHsNCj4+PiAg
wqDCoMKgwqDCoCBfX2xlNjQgbnVtX2JpdG1hcHM7DQo+Pj4gIMKgIH0gX19hdHRyaWJ1dGVfXyAo
KF9fcGFja2VkX18pKTsNCj4+PiArc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlIHsNCj4+PiArwqDC
oMKgIC8qIFRoZSBidHJmcyBkZXZpY2UtaWQgdGhpcyByYWlkIGV4dGVudCBsaXZlcyBvbiAqLw0K
Pj4+ICvCoMKgwqAgX19sZTY0IGRldmlkOw0KPj4+ICvCoMKgwqAgLyogVGhlIHBoeXNpY2FsIGxv
Y2F0aW9uIG9uIGRpc2sgKi8NCj4+PiArwqDCoMKgIF9fbGU2NCBwaHlzaWNhbDsNCj4+PiArwqDC
oMKgIC8qIFRoZSBsZW5ndGggb2Ygc3RyaWRlIG9uIHRoaXMgZGlzayAqLw0KPj4+ICvCoMKgwqAg
X19sZTY0IGxlbmd0aDsNCj4gDQo+IEZvcmdvdCB0byBtZW50aW9uLCBmb3IgYnRyZnNfc3RyaXBl
X2V4dGVudCBzdHJ1Y3R1cmUsIGl0cyBrZXkgaXMNCj4gKFBIWVNJQ0FMLCBSQUlEX1NUUklQRV9L
RVksIExFTkdUSCkgcmlnaHQ/DQo+IA0KPiBTbyBpcyB0aGUgbGVuZ3RoIGluIHRoZSBidHJmc19y
YWlkX3N0cmlkZSBkdXBsaWNhdGVkIGFuZCB3ZSBjYW4gc2F2ZSA4DQo+IGJ5dGVzPw0KDQpOb3Bl
LiBUaGUgbGVuZ3RoIGluIHRoZSBrZXkgaXMgdGhlIHN0cmlwZSBsZW5ndGguIFRoZSBsZW5ndGgg
aW4gdGhlIA0Kc3RyaWRlIGlzIHRoZSBzdHJpZGUgbGVuZ3RoLg0KDQpIZXJlJ3MgYW4gZXhhbXBs
ZSBmb3Igd2h5IHRoaXMgaXMgbmVlZGVkOg0KDQp3cm90ZSAzMjc2OC8zMjc2OCBieXRlcyBhdCBv
ZmZzZXQgMA0KWFhYIEJ5dGVzLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhY
WCBvcHMvc2VjKQ0Kd3JvdGUgMTMxMDcyLzEzMTA3MiBieXRlcyBhdCBvZmZzZXQgMA0KWFhYIEJ5
dGVzLCBYIG9wczsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0Kd3Jv
dGUgODE5Mi84MTkyIGJ5dGVzIGF0IG9mZnNldCA2NTUzNg0KWFhYIEJ5dGVzLCBYIG9wczsgWFg6
WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KDQpbc25pcF0NCg0KICAgICAg
ICAgaXRlbSAwIGtleSAoWFhYWFhYIFJBSURfU1RSSVBFX0tFWSAzMjc2OCkgaXRlbW9mZiBYWFhY
WCBpdGVtc2l6ZSAzMg0KICAgICAgICAgICAgICAgICAgICAgICAgIGVuY29kaW5nOiBSQUlEMA0K
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmlwZSAwIGRldmlkIDEgcGh5c2ljYWwgWFhYWFhY
WFhYIGxlbmd0aCAzMjc2OA0KICAgICAgICAgaXRlbSAxIGtleSAoWFhYWFhYIFJBSURfU1RSSVBF
X0tFWSAxMzEwNzIpIGl0ZW1vZmYgWFhYWFggDQppdGVtc2l6ZSA4MA0KICAgICAgICAgICAgICAg
ICAgICAgICAgIGVuY29kaW5nOiBSQUlEMA0KICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmlw
ZSAwIGRldmlkIDEgcGh5c2ljYWwgWFhYWFhYWFhYIGxlbmd0aCAzMjc2OA0KICAgICAgICAgICAg
ICAgICAgICAgICAgIHN0cmlwZSAxIGRldmlkIDIgcGh5c2ljYWwgWFhYWFhYWFhYIGxlbmd0aCA2
NTUzNg0KICAgICAgICAgICAgICAgICAgICAgICAgIHN0cmlwZSAyIGRldmlkIDEgcGh5c2ljYWwg
WFhYWFhYWFhYIGxlbmd0aCAzMjc2OA0KICAgICAgICAgaXRlbSAyIGtleSAoWFhYWFhYIFJBSURf
U1RSSVBFX0tFWSA4MTkyKSBpdGVtb2ZmIFhYWFhYIGl0ZW1zaXplIDMyDQogICAgICAgICAgICAg
ICAgICAgICAgICAgZW5jb2Rpbmc6IFJBSUQwDQogICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
aXBlIDAgZGV2aWQgMSBwaHlzaWNhbCBYWFhYWFhYWFggbGVuZ3RoIDgxOTINCg0KV2l0aG91dCB0
aGUgbGVuZ3RoIGluIHRoZSBzdHJpZGUsIHdlIGRvbid0IGtub3cgd2hlbiB0byBzZWxlY3QgdGhl
IG5leHQgDQpzdHJpZGUgaW4gaXRlbSAxIGFib3ZlLg0K
