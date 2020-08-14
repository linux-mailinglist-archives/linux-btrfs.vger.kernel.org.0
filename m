Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA1F244298
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHNAyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:54:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:45451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHNAye (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597366471;
        bh=YeKYzMT8ScIIM+W1jG85lU29Z9j4FAH6n235+Jy2z6Y=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=AXCUT15LDlgKDCO4OyWImNF186PrDprQAJ5Yed90i++nbstUl8Uf2YL7R7wNm3Jhi
         f9aHNUEb8rN9HQpf2YpALVbIVZhgY0l10CMili7Imbyux5h36ldHjuXJ77eGHEu657
         Cu1g93ZmLSUHkDGX46NJWmYHrc/VSyJyUeZIMrqo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1kfiwH3jn9-00aEIh; Fri, 14
 Aug 2020 02:54:31 +0200
Subject: Re: [PATCH v4 4/4] btrfs: ctree: Checking key orders before merged
 tree blocks
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <20200812060509.71590-1-wqu@suse.com>
 <20200812060509.71590-5-wqu@suse.com> <20200813142121.GJ2026@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <455de733-ce1a-0c4f-19c9-6503d8bf9bca@gmx.com>
Date:   Fri, 14 Aug 2020 08:54:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813142121.GJ2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q651424jVe77hKbOgATIEUZZTA7u5MBW+KeDEinhbbWr9xVR9oJ
 fH5GOLHF4L4k6H4Kpv1AZsQ60A9RMoX/lPPloEVBR4rIaDbVPvZzCw6m+Zo8KaSe/IIUaXW
 Ze803b/Q/YAao5WU+WyGNIzvpVDJRqYhytn/Y+lJTgY32O1StyJFJ2Jxxbfr6eG3VhwDNcy
 9inrooeqpWTNfVj2kBt/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:w3tjAdl5Jqc=:VDvbHY8no8EjnfULezM380
 6ep3NeKJn6o5wZs0eGcLiFsLxhnCLlZb5vgtlvP9A/E+Jwe3VEYom4lbuRzngkvyJyom71Dp+
 iq82kHmXnmVUFD294F1SdaJilcGj5Bg9miEO+t262SLtcj/RZc1t50y5Bzen0gnwbp79nURM7
 5Q4HNyCTzl+CqTBqv0R9G24ZfBl8BY3D1sIGT6l4l6ZeVTxXeGXOu2GzOAaKBSOyqlfK6CJ3E
 jTrlpAWeweN+q74eSmpoScZHJaMBKAFPVxy0SEe+qcraNXYnb1MjA6VPn9R3AcC4nl2uF55xw
 p1wYShq+72iMQs4lI2p+G9jcB9TRVyTQdIDQBijCBbyf0f3hMa3+5SZbL9dhxFbQon9iO5eKu
 93rReMkx4ADbWx7DbsHFYZkQ4gAPaPiYvJSSKLh+n6NF21Jguy9LD7CIxz6z0qb6S0Gs+92nD
 p1DQDWhP+RdZrIPEdeg5m80409kEFfOQ0dJ+t7ggDQ2cmuMeMicTKR2f7hK0OV/4+WG8VOD59
 W2dG9Q4na3YVJ8iliWxiHtsmT9BNnXH0pqHDLXslLV3FgqIAfLQ0+kaJmaqtD0BH7RZrdF9ic
 ybrHTmLfVwN2SoneAkQOpM7fNaPCDa7cOwLmqcqu1MqZ2cUoYbsia0PqTxkkDYo/95ze8bmxf
 qmEZYg6xpIXuAccCHFt7kxdn8lSdwgX/PUXHacZL8dvLhMWipWQSjoUxgGQElbapdX+qXGIEj
 MqRFT8Bd8xEHEBLf7geC1WXBjGeWAfQC0hZ/sjQGyFReWGGLVd2G5FDhMOXMutvhw8vdQF/6A
 bpznQMoxLgHc9L1HfKD70dycTmynIVKY9vgIHH9TSPlmcCFYwVKY10reRseaEeRyILlciXdbb
 0H970CnHa3+STcIyFlX45gr8IxJ14Ndxcc7FaMz/QN2RDrYLaoEPAuKkMleFfHBDz0I67Fw6H
 w4KtTMuiq6bT/eZtWqZSlCUvNCfVCEI5v46XaYCSS6IEkcVHNCnd5ytriWbJzpvSMUqSUI+97
 496/H4xPwBUM1TeoaGangtD9TdhmPPINXgwzskhFrilECL6Y1oJkk3rz1NlJ/zez+3NhrSxc0
 mLp38K4l2RwkCoS1r4eG7c6LM88G0byvmWNA40QIBGAbAJTqOuODteUEa8X43hSt3sNCyItCb
 XDhwvfi9P/xYaq2LaCVHWLPYdsVBRk1J4kCFSULW/aAHGtdZGbmEJRpXopXowunkMq4PQ+R0w
 usUrsW/I+MTZjsR25hQ5JgNaFcx8FHIYkXWeDmQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/13 =E4=B8=8B=E5=8D=8810:21, David Sterba wrote:
> On Wed, Aug 12, 2020 at 02:05:09PM +0800, Qu Wenruo wrote:
[...]
>> ---
>>  fs/btrfs/ctree.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index 70e49d8d4f6c..497abb397ea1 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -3159,6 +3159,52 @@ void btrfs_set_item_key_safe(struct btrfs_fs_inf=
o *fs_info,
>>  		fixup_low_keys(path, &disk_key, 1);
>>  }
>>
>> +/*
>> + * Check the cross tree block key ordering.
>> + *
>> + * Tree-checker only works inside one tree block, thus the following
>> + * corruption can not be rejected by tree-checker:
>> + * Leaf @left			| Leaf @right
>> + * --------------------------------------------------------------
>> + * | 1 | 2 | 3 | 4 | 5 | f6 |   | 7 | 8 |
>> + *
>> + * Key f6 in leaf @left itself is valid, but not valid when the next
>> + * key in leaf @right is 7.
>> + * This can only be checked at tree block merge time.
>> + * And since tree checker has ensured all key order in each tree block
>> + * is correct, we only need to bother the last key of @left and the fi=
rst
>> + * key of @right.
>> + */
>> +static bool valid_cross_tree_key_order(struct extent_buffer *left,
>> +				       struct extent_buffer *right)
>
> I think this naming is confusing, my first thought was that keys from
> two trees were being checked, but this is for two leaves in the same
> tree.
>
> The arguments should be constified.
>
> Elsewhere we use a check_<something> naming scheme with return value
> true - problem, and 0/false - all ok. The 'valid' is the reverse and
> also not following the scheme.

Any good candidate?

My current top list candidate is, check_sibling_keys().

Thanks,
Qu

>
>> +{
>> +	struct btrfs_key left_last;
>> +	struct btrfs_key right_first;
>> +	int level =3D btrfs_header_level(left);
>> +	int nr_left =3D btrfs_header_nritems(left);
>> +	int nr_right =3D btrfs_header_nritems(right);
>> +
>> +	/* No key to check in one of the tree blocks */
>> +	if (!nr_left || !nr_right)
>> +		return true;
>> +	if (level) {
>
> You don't need a temporary variable for one-time use, btrfs_header_level
> is understandable here.
>
