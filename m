Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEF4244623
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 10:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgHNIH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Aug 2020 04:07:28 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:48748 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgHNIH1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Aug 2020 04:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597392444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QUHOSgD1SSPgIIY7jMHT1rhSvCPbm9oxfYyNr/iyWvU=;
        b=YcY8R9xoT0WC499G5rs2jg4w2TZ5zq3rFwQ+YgouWJO/9/pU+oMhMyOPorsVlxAjpjTifm
        j1Zanq63C4eHu3Id+rERo2fiydeltlLBTGFU5NyMNHBr8RQSE1K0NYbgVj2epy4M0swx0V
        rw0ZdchY4qSivwURfdw/TiMiYK0aUQo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-7-lU368DWzPCypDMMnbXgAlw-2; Fri, 14 Aug 2020 10:07:23 +0200
X-MC-Unique: lU368DWzPCypDMMnbXgAlw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt0UgrboQUji/RE1qisQ2ESaFFr3QDOF1upNn6tMyW1f22xwuViiHq5HMUfRBZpWMWF78rV08xA26+A1tlgjPZ4DNDomtujxErkej897ynKlOyKhgNVA2jSMpn8ypWgRAAvXYKpKQQGRrcwK0B/ijOwphNI5G9yscBGdLIe+t8JaBaZbiCvozRQhLcooRZFLbZDr3BKM+KOey1o3+IgubOtRKeh5FmfALRrBirThXPLVqrA5/csD+20u9fdlUq0xgW1M4ZKeb5L0I5YwVJBVk3jHiZDqQnFmb0AN0HU8GvFqBdxqlIgKVIORchYyeZi0V1Nv2yamWIYBios/COPwRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfAWxAfxz635uoaxiI6/OyM3WmfE7VyIBUeRDn7vyaw=;
 b=dWb/fu74U73oJqkfqyjK9g2WGdaa6KvGQ4ND1r0QLsPqF4jUjUWGfc2Ky+JfBFCSW1hFtHkWTT/tlC1kieW0YVmj0amcV01gJy66UIKGBJvW+kRUzgq0nphqU5wocoasvUkHdAlFIabeUljzITXoQh/i2V/2WhbdMt5YZvbXDYwAV9I1um5ayHc1ETra428s7XodTSiNtKaVK10PYVeN4FojZZZRzncwGUS9lswN+ZUu4yWztWm78bKtnN1VhNRkd/nCzVGc6hnyZrzxKqDdKSfdyHClSMurhnF+DpMfkv0agZNdeu/R4MLmYAODtfOJhu35T9zs0SdGp8Nc2EHOyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM4PR0401MB2273.eurprd04.prod.outlook.com (2603:10a6:200:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 08:07:21 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.026; Fri, 14 Aug 2020
 08:07:21 +0000
Subject: Re: [PATCH v4 2/4] btrfs: extent-tree: Kill BUG_ON() in
 __btrfs_free_extent() and do better comment
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-3-wqu@suse.com> <20200813141019.GI2026@twin.jikos.cz>
 <bf3d96a8-f19c-1b0d-9171-c82f7a4d3d0f@gmx.com>
 <20200814080124.GT2026@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <4d1a93dd-b90b-82cc-3e0c-39e658bfbf2e@suse.com>
Date:   Fri, 14 Aug 2020 16:07:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200814080124.GT2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Fri, 14 Aug 2020 08:07:18 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2206e8-1d9e-47b5-f15d-08d840291212
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2273:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB2273359C83392D0C57446282D6400@AM4PR0401MB2273.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(31686004)(956004)(2616005)(6486002)(66476007)(66556008)(36756003)(966005)(478600001)(5660300002)(66946007)(16576012)(316002)(110136005)(16526019)(2906002)(26005)(186003)(86362001)(52116002)(31696002)(6706004)(8936002)(6666004)(16799955002)(8676002)(83380400001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2206e8-1d9e-47b5-f15d-08d840291212
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 08:07:21.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXlLQqvrQTiWI1OYDKq3rTKfym0gRZylPE66PUE22gdUNbgeQOgMnNUWJTC/QCmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2273
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/14 =E4=B8=8B=E5=8D=884:01, David Sterba wrote:
> On Fri, Aug 14, 2020 at 08:52:19AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2020/8/13 =E4=B8=8B=E5=8D=8810:10, David Sterba wrote:
>>> On Wed, Aug 12, 2020 at 02:05:07PM +0800, Qu Wenruo wrote:
>>>> @@ -2987,13 +3049,20 @@ static int __btrfs_free_extent(struct btrfs_tr=
ans_handle *trans,
>>>>  				found_extent =3D 1;
>>>>  				break;
>>>>  			}
>>>> +
>>>> +			/* Quick path didn't find the EXTEMT/METADATA_ITEM */
>>>>  			if (path->slots[0] - extent_slot > 5)
>>>>  				break;
>>>>  			extent_slot--;
>>>>  		}
>>>>
>>>>  		if (!found_extent) {
>>>> -			BUG_ON(iref);
>>>> +			if (unlikely(iref)) {
>>>> +				btrfs_crit(info,
>>>> +"invalid iref, no EXTENT/METADATA_ITEM found but has inline extent re=
f");
>>>> +				goto err_dump_abort;
>>>
>>> This is not calling transaction abort at the place where it happens,
>>> here and several other places too.
>>
>> Did you mean, we want the btrfs_abort_transaction() call not merged
>> under one tag, so that we can get the kernel warning with the line numbe=
r?
>>
>> If so, that's indeed the case, we lose the exact line number.
>>
>> But we still have the unique error message to locate the problem without
>> much hassle (it's less obvious than the line number thought).
>>
>> Thus to me, we don't lose much debug info anyway.
>=20
> https://btrfs.wiki.kernel.org/index.php/Development_notes#Error_handling_=
and_transaction_abort
>=20
> "Please keep all transaction abort exactly at the place where they happen
> and do not merge them to one. This pattern should be used everwhere and
> is important when debugging because we can pinpoint the line in the code
> from the syslog message and do not have to guess which way it got to the
> merged call."
>=20
> It's very convenient to paste the file:line number from a stacktrace
> report and land exactly in the spot where it failed.
>=20
OK, makse sense.

Will go that direction in next update.

Thanks,
Qu

